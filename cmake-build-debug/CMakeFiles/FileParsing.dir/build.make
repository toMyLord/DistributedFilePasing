# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/mylord/bin/clion-2019.2.2/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/mylord/bin/clion-2019.2.2/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mylord/Programs/CLionProjects/DistributedFileParsing

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/FileParsing.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/FileParsing.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/FileParsing.dir/flags.make

CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.o: CMakeFiles/FileParsing.dir/flags.make
CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.o: ../fileparsing/FileParsing_main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.o -c /home/mylord/Programs/CLionProjects/DistributedFileParsing/fileparsing/FileParsing_main.cpp

CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mylord/Programs/CLionProjects/DistributedFileParsing/fileparsing/FileParsing_main.cpp > CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.i

CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mylord/Programs/CLionProjects/DistributedFileParsing/fileparsing/FileParsing_main.cpp -o CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.s

# Object files for target FileParsing
FileParsing_OBJECTS = \
"CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.o"

# External object files for target FileParsing
FileParsing_EXTERNAL_OBJECTS =

FileParsing: CMakeFiles/FileParsing.dir/fileparsing/FileParsing_main.cpp.o
FileParsing: CMakeFiles/FileParsing.dir/build.make
FileParsing: CMakeFiles/FileParsing.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable FileParsing"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/FileParsing.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/FileParsing.dir/build: FileParsing

.PHONY : CMakeFiles/FileParsing.dir/build

CMakeFiles/FileParsing.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/FileParsing.dir/cmake_clean.cmake
.PHONY : CMakeFiles/FileParsing.dir/clean

CMakeFiles/FileParsing.dir/depend:
	cd /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mylord/Programs/CLionProjects/DistributedFileParsing /home/mylord/Programs/CLionProjects/DistributedFileParsing /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug/CMakeFiles/FileParsing.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/FileParsing.dir/depend

