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
## @author     Adrian Antonana <adrian.antonana@stackforce.de>
## @brief      Libserialport cmake find module
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

cmake_minimum_required(VERSION 3.6)

include(ExternalProject)

# try to find the serialport library
set(SERIALPORT_LIB_DIR ${CMAKE_CURRENT_BINARY_DIR}/serialport-prefix/src/serialport/.libs)
find_library(SERIALPORT_LIB serialport ${SERIALPORT_LIB_DIR})

# if the library is not found download and build it
if(NOT SERIALPORT_LIB)

    message(STATUS "Serialport: Not found")
    message(STATUS "Serialport: Project will be downloaded and built")

    ExternalProject_Add(serialport
        GIT_REPOSITORY "git://sigrok.org/libserialport"
        GIT_TAG "0c3f38b81b8968d78806a7a41ed351a870882b5e"
        UPDATE_DISCONNECTED 1
        CONFIGURE_COMMAND ./autogen.sh && ./configure
        BUILD_COMMAND make
        BUILD_IN_SOURCE 1
        INSTALL_COMMAND ""
    )

    ExternalProject_Get_Property(serialport source_dir binary_dir)

    message(STATUS "Serialport source path: ${source_dir}")
    message(STATUS "Serialport build path: ${binary_dir}")
    message(STATUS "Serialport library path: ${SERIALPORT_LIB_DIR}")

    add_custom_target(libserialport-bootstrap
                      COMMAND ${CMAKE_COMMAND} ${CMAKE_SOURCE_DIR}
                      WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
                      DEPENDS serialport
    )
else()
    message(STATUS "Serialport: Found")
    message(STATUS "Serialport source path: ${source_dir}")
    message(STATUS "Serialport build path: ${binary_dir}")
    message(STATUS "Serialport library path: ${SERIALPORT_LIB_DIR}")
    add_custom_target(libserialport-bootstrap)
endif()

# at configure time this path has to exist for INTERFACE_INCLUDE_DIRECTORIES to work
file(MAKE_DIRECTORY "${source_dir}")

# add the static and dynamic libraries
add_library(libserialport IMPORTED SHARED GLOBAL)
add_library(libserialport-static IMPORTED STATIC GLOBAL)
add_dependencies(libserialport serialport-bootstrap)
add_dependencies(libserialport-static serialport-bootstrap)

set_target_properties(libserialport PROPERTIES
	IMPORTED_LOCATION "${SERIALPORT_LIB_DIR}/libserialport.so"
	INTERFACE_INCLUDE_DIRECTORIES "${source_dir}"
)

set_target_properties(libserialport-static PROPERTIES
	IMPORTED_LOCATION "${SERIALPORT_LIB_DIR}/libserialport.a"
	INTERFACE_INCLUDE_DIRECTORIES "${source_dir}"
)
