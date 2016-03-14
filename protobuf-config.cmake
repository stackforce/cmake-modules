##
## @code
##  ___ _____ _   ___ _  _____ ___  ___  ___ ___
## / __|_   _/_\ / __| |/ / __/ _ \| _ \/ __| __|
## \__ \ | |/ _ \ (__| ' <| _| (_) |   / (__| _|
## |___/ |_/_/ \_\___|_|\_\_| \___/|_|_\\___|___|
## embedded.connectivity.solutions.==============
## @endcode
##
## @file
## @copyright  STACKFORCE GmbH, Heitersheim, Germany, http://www.stackforce.de
## @author     STACKFORCE
## @brief      STACKFORCE CMake Module for googeltest
##
## This file is part of the STACKFORCE CMake modules collection
## (below "sf cmake modules collection").
##
## sf cmake modules collection is free software: you can redistribute it
## and/or modify it under the terms of the GNU Affero General Public License
## as published by the Free Software Foundation, either version 3 of the
## License, or (at your option) any later version.
##
## sf cmake modules collection is distributed in the hope that it will be
## useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Affero General Public License for more details.
##
## You should have received a copy of the GNU Affero General Public License
## along with sf cmake modules collection.
## If not, see <http://www.gnu.org/licenses/>.
##
cmake_minimum_required (VERSION 2.8)

if(protobuf_FOUND)
    MESSAGE(STATUS "protobuf found!")
else()
    MESSAGE(STATUS "Make protobuf!")

    # Enable ExternalProject CMake module
    include(ExternalProject)

    set(PROTOBUF_GIT_REPOSITORY https://github.com/google/protobuf)
    set(PROTOBUF_GIT_TAG master)

    if(${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} VERSION_LESS "3.2")
        message(STATUS "CMake version ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}")
        message(STATUS "Retarded CMake distributor detected. Are you using ubuntu?")

        ExternalProject_Add(protobuf   # Name for custom target

            GIT_REPOSITORY ${PROTOBUF_GIT_REPOSITORY}

            GIT_TAG ${PROTOBUF_GIT_TAG}
            
	    CONFIGURE_COMMAND ./autogen.sh && ./configure --prefix=<INSTALL_DIR>

	    #--Build step-----------------
	    BUILD_COMMAND make && make check
	    BUILD_IN_SOURCE 1
	    BUILD_ALWAYS 0
	    
	    PATCH_COMMAND ""
	    
	    #--Install step-----------------
	    INSTALL_COMMAND make install
            )
    else()
        message(STATUS "CMake version ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}")

        ExternalProject_Add(protobuf   # Name for custom target

            GIT_REPOSITORY ${PROTOBUF_GIT_REPOSITORY}

            GIT_TAG ${PROTOBUF_GIT_TAG}
            
	    CONFIGURE_COMMAND ./autogen.sh && ./configure --prefix=<INSTALL_DIR>

	    #--Build step-----------------
	    BUILD_COMMAND make && make check
	    BUILD_IN_SOURCE 1
	    BUILD_ALWAYS 0
	    
	    # Never update automatically from the remote repository
            UPDATE_DISCONNECTED 1
            
	    PATCH_COMMAND ""
	    #--Install step-----------------
	    INSTALL_COMMAND make install
            )
    endif()

    add_library(libprotobuf IMPORTED STATIC GLOBAL)
    add_dependencies(libprotobuf protobuf)

    # Set gmock properties
    ExternalProject_Get_Property(protobuf source_dir binary_dir install_dir )
    set_target_properties(libprotobuf PROPERTIES
        "IMPORTED_LOCATION" "${install_dir}/lib/libprotobuf.a"
        "IMPORTED_LINK_INTERFACE_LIBRARIES" "${CMAKE_THREAD_LIBS_INIT}"
        #    "INTERFACE_INCLUDE_DIRECTORIES" "${source_dir}/include"
        )
    include_directories("${install_dir}/include")
endif()
