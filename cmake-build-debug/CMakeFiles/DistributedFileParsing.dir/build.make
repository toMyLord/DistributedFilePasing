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
include CMakeFiles/DistributedFileParsing.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/DistributedFileParsing.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/DistributedFileParsing.dir/flags.make

CMakeFiles/DistributedFileParsing.dir/main.cpp.o: CMakeFiles/DistributedFileParsing.dir/flags.make
CMakeFiles/DistributedFileParsing.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/DistributedFileParsing.dir/main.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/DistributedFileParsing.dir/main.cpp.o -c /home/mylord/Programs/CLionProjects/DistributedFileParsing/main.cpp

CMakeFiles/DistributedFileParsing.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DistributedFileParsing.dir/main.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mylord/Programs/CLionProjects/DistributedFileParsing/main.cpp > CMakeFiles/DistributedFileParsing.dir/main.cpp.i

CMakeFiles/DistributedFileParsing.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DistributedFileParsing.dir/main.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mylord/Programs/CLionProjects/DistributedFileParsing/main.cpp -o CMakeFiles/DistributedFileParsing.dir/main.cpp.s

# Object files for target DistributedFileParsing
DistributedFileParsing_OBJECTS = \
"CMakeFiles/DistributedFileParsing.dir/main.cpp.o"

# External object files for target DistributedFileParsing
DistributedFileParsing_EXTERNAL_OBJECTS =

DistributedFileParsing: CMakeFiles/DistributedFileParsing.dir/main.cpp.o
DistributedFileParsing: CMakeFiles/DistributedFileParsing.dir/build.make
DistributedFileParsing: CMakeFiles/DistributedFileParsing.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable DistributedFileParsing"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/DistributedFileParsing.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/DistributedFileParsing.dir/build: DistributedFileParsing

.PHONY : CMakeFiles/DistributedFileParsing.dir/build

CMakeFiles/DistributedFileParsing.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/DistributedFileParsing.dir/cmake_clean.cmake
.PHONY : CMakeFiles/DistributedFileParsing.dir/clean

CMakeFiles/DistributedFileParsing.dir/depend:
	cd /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mylord/Programs/CLionProjects/DistributedFileParsing /home/mylord/Programs/CLionProjects/DistributedFileParsing /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug /home/mylord/Programs/CLionProjects/DistributedFileParsing/cmake-build-debug/CMakeFiles/DistributedFileParsing.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/DistributedFileParsing.dir/depend

