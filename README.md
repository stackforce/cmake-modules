# Usage

Add this repo as a submodule to `${CMAKE_SOURCE_DIR}/cmake/modules` where `${CMAKE_SOURCE_DIR}` is the location of your CMakeLists.txt file.

In your CMakeLists.txt include this line to add the modules to cmake's find path:

    list(APPEND CMAKE_FIND_ROOT_PATH ${CMAKE_SOURCE_DIR}/cmake/modules)

To use a package add this line to your CMakeLists.txt

    find_package(gtest)

