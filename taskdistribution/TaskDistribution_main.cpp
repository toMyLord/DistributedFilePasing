//
// Created by mylord on 2019/10/31.
//
#include "src/distribution_server.h"
#include <sys/epoll.h>
#include <thread>
#include <queue>
#include <mutex>

typedef struct {
    int parsing_fd;
}ReadyParsingNode;

DistributionServer workstation_server(5555, 10);
DistributionServer parsing_server(6666, 10);
Server manager_server(7777, 1);
bool is_manager_connected = false;              //记录管理平台是否连接
int manager_fd;                                 //管理平台客户端的fd
queue<ReadyParsingNode> ready_parsing_queue;    //需要加互斥锁
mutex queue_mutex;                              //给就绪队列加的互斥锁

void FileHandler_t(int workstation_fd, const ClientNode & workstation_node);

int main() {
    struct epoll_event ev, events[3];       //声明epoll_event结构体的变量,ev用于注册事件,数组用于回传要处理的事件
    int epoll_fd = epoll_create(3);     //创建一个epoll的句柄，并告诉内核这个监听的数目为10
    int nfds;                               //记录需要处理的事件数
    ClientInfo manager_info;                //管理平台客户端的信息
    SpecificTime st;

    ev.events = EPOLLIN | EPOLLET;          //linsten_fd可读，边缘触发

    //将用于接受工作站信息的连接监听fd加入epoll池中
    ev.data.fd = workstation_server.getListenFd();
    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, workstation_server.getListenFd(), &ev);
    cout << "[" << st.getTime().c_str() << " Listening WorkStation]:\tListen to WorkStation at port 5555." << endl;

    //将用于接受文件解析服务器信息的连接监听fd加入epoll池中
    ev.data.fd = parsing_server.getListenFd();
    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, parsing_server.getListenFd(), &ev);
    cout << "[" << st.getTime().c_str() << " Listening Parser]:\tListen to Parser at port 6666." << endl;

    //将用于接受管理平台的连接监听fd加入epoll池中
    ev.data.fd = manager_server.getListenFd();
    epoll_ctl(epoll_fd, EPOLL_CTL_ADD, manager_server.getListenFd(), &ev);
    cout << "[" << st.getTime().c_str() << " Listening Manager]:\tListen to Manager at port 7777." << endl;

    while(true) {
        nfds = epoll_wait(epoll_fd, events, 10, -1);
        for(int i = 0; i < nfds; i++){
            if(events[i].data.fd == workstation_server.getListenFd()) {
                //有工作站连接至任务分配服务器
                //开线程监视一个完整的文件解析过程，接收来自工作站的解析请求以及接收来自文件解析服务器的解析完成回应都需要用阻塞的read
                ClientNode workstation_node;
                int workstation_fd = workstation_server.AcceptConnection(workstation_node);

                thread forward_t(FileHandler_t, workstation_fd, workstation_node);

                forward_t.detach();

                cout << "[" << st.getTime().c_str() << " Connected WorkStation]:\tWorkstation "
                    << workstation_node.client_info.client_ip << " is connected." << endl;


                if(is_manager_connected == true) {
                    //通知管理平台有新上线的工作站.信息在workstation_node中
                    char buffer[1024];
                    string buff("ws:");
                    workstation_server.getAllClientInfo(buff);
                    strcpy(buffer, buff.c_str());
                    manager_server.Write(manager_fd, buffer);
                }
            } else if(events[i].data.fd == parsing_server.getListenFd()) {
                //有文件解析服务器连接至任务分配服务器
                ClientNode parsing_node;
                int parsing_fd = parsing_server.AcceptConnection(parsing_node);

                //当有文件解析服务器加入任务分配服务器时，直接将其加入就绪队列
                ReadyParsingNode temp;
                temp.parsing_fd = parsing_fd;

                queue_mutex.lock();
                ready_parsing_queue.push(temp);
                queue_mutex.unlock();

                cout << "[" << st.getTime().c_str() << " Connected Parser]:\tParser "
                     << parsing_node.client_info.client_ip << " is connected and added to queue." << endl;

                if(is_manager_connected == true) {
                    //通知管理平台有新上线的文件解析服务器,信息在parsing_node中
                    char buffer[1024];
                    string buff("fp:");
                    parsing_server.getAllClientInfo(buff);
                    strcpy(buffer, buff.c_str());
                    manager_server.Write(manager_fd, buffer);
                }
            } else if(events[i].data.fd == manager_server.getListenFd()) {
                //有文件管理平台连接至任务分配服务器
                //谨记：管理平台只能连接一个!!!
                if(is_manager_connected == false) {
                    //如果管理平台还未连接，则连接管理平台
                    manager_fd = manager_server.AcceptConnection(manager_info);

                    is_manager_connected = true;

                    cout << "[" << st.getTime().c_str() << " Connected Manager]:\tManager "
                         << manager_info.client_ip << " is connected to Task Distributer." << endl;

                    //连接后需要向管理平台发送已经上线的所有工作站及文件解析服务器的信息
                    char buffer[1024];

                    string buff("ws:");
                    workstation_server.getAllClientInfo(buff);
                    strcpy(buffer, buff.c_str());
                    manager_server.Write(manager_fd, buffer);

                    memset(buffer, 0, 1024);
                    usleep(0);

                    buff.clear();
                    buff += "fp:";
                    parsing_server.getAllClientInfo(buff);
                    strcpy(buffer, buff.c_str());
                    manager_server.Write(manager_fd, buffer);
                }

            } else {
                time_t curtime;
                time(&curtime);
                cout << "[Epoll Error]:" << ctime(&curtime) << " no corresponding Epoll event found" << endl;
            }
        }
    }
}

void FileHandler_t(int workstation_fd, const ClientNode & workstation_node) {
    char buffer[1024];
    int nbytes = 0;
    SpecificTime st;

    while(true) {
        //等待工作站发来的文件解析请求
        if((nbytes = workstation_server.Read(workstation_fd, buffer)) <= 0) {
            workstation_server.Close(workstation_fd);
            break;
        }

        //对发送来的数据进行解析并根据就绪队列向文件解析服务器发送连接命令，如果就绪队列为空，就等待1s
        if (strncmp(buffer, "ParsingRequest", 14) != 0) {
            cout << "[" << st.getTime().c_str() <<
            " Request Warning]:\tTask distribution server cann't parse the request from workstation!" << endl;
            continue;
        }

        cout << "[" << st.getTime().c_str() <<
             " Request Received]:\tParsing request was received, start distributing!" << endl;

        while(true) {
            queue_mutex.lock();
            if(ready_parsing_queue.empty() != 1)    //如果就绪队列不空，先不拿掉锁，等pop之后再取锁
                break;
            queue_mutex.unlock();
            sleep(1);
        }
        int parsing_fd = ready_parsing_queue.front().parsing_fd;
        ready_parsing_queue.pop();
        queue_mutex.unlock();

        //构造好接口，buffer内需要有工作站的ip信息,端口=8888
        int lenth = workstation_node.client_info.client_ip.length();
        workstation_node.client_info.client_ip.copy(buffer, lenth);
        buffer[lenth] = '\0';
        parsing_server.Write(parsing_fd, buffer);

        workstation_server.setState(workstation_fd, TRANSIMITING);
        parsing_server.setState(parsing_fd, TRANSIMITING);

        //向管理平台发送正在解析文件信息
        char buffer[1024];

        string buff("ws:");
        workstation_server.getAllClientInfo(buff);
        strcpy(buffer, buff.c_str());
        manager_server.Write(manager_fd, buffer);

        memset(buffer, 0, 1024);
        usleep(0);

        buff.clear();
        buff += "fp:";
        parsing_server.getAllClientInfo(buff);
        strcpy(buffer, buff.c_str());
        manager_server.Write(manager_fd, buffer);


        //等待文件解析服务器发送的解析完成信息，并将此文件解析服务器重新送入就绪队列
        if((nbytes = parsing_server.Read(parsing_fd, buffer)) <= 0) {
            parsing_server.Close(parsing_fd);
            break;
        }
        if (strncmp(buffer, "ParsingSuccess", 14) != 0) {
            cout << "[" << st.getTime().c_str() <<
                 " Request Exception]:\tTask distribution server didn't receive the parse completion signal!" << endl;

            parsing_server.Close(parsing_fd);
            continue;
        } else {
            ReadyParsingNode temp;
            temp.parsing_fd = parsing_fd;

            queue_mutex.lock();
            ready_parsing_queue.push(temp);
            queue_mutex.unlock();

            cout << "[" << st.getTime().c_str() <<
                 " Parsing Success]:\tParse file succeed!" << endl;


            workstation_server.setState(workstation_fd, WAITING);
            parsing_server.setState(parsing_fd, WAITING);
            //向管理平台发送解析完成信息（工作站和解析服务器的）

            buff.clear();
            buff += "ws:";
            workstation_server.getAllClientInfo(buff);
            strcpy(buffer, buff.c_str());
            manager_server.Write(manager_fd, buffer);

            memset(buffer, 0, 1024);
            usleep(0);

            buff.clear();
            buff += "fp:";
            parsing_server.getAllClientInfo(buff);
            strcpy(buffer, buff.c_str());
            manager_server.Write(manager_fd, buffer);
        }
    }
}