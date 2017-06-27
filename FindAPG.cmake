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
## @brief      Wireless MBus telegram parser
##
## @details Advanced Parser Generator cmake find module
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

set(APG_PREFIX_DIR ${PROJECT_BINARY_DIR}/apg-prefix)
set(APG_BUILD_DIR ${APG_PREFIX_DIR}/build)
set(APG_INCLUDE_DIR_LIB ${APG_PREFIX_DIR}/src/apg/ApgLib)
set(APG_INCLUDE_DIR_UTILS ${APG_PREFIX_DIR}/src/apg/ApgUtilities)
set(APG_INCLUDE_DIRS_ALL ${APG_INCLUDE_DIR_LIB} ${APG_INCLUDE_DIR_UTILS})

set(APG_OBJECT_FILES
    ${APG_BUILD_DIR}/ApgLib/apg-Ast.o
    ${APG_BUILD_DIR}/ApgLib/apg-Operators.o
    ${APG_BUILD_DIR}/ApgLib/apg-Memory.o
    ${APG_BUILD_DIR}/ApgLib/apg-Tools.o
    ${APG_BUILD_DIR}/ApgLib/apg-Parser.o
    ${APG_BUILD_DIR}/ApgUtilities/apg-Files.o
    ${APG_BUILD_DIR}/ApgUtilities/apg-Utilities.o
)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    MESSAGE(STATUS "DEBUG mode")
    set(APG_COMMAND ${APG_BUILD_DIR}/apg_dbg)
    set(APG_CONFIGURE_PARAMETER ${APG_CONFIGURE_PARAMETER} --enable-debug)
else()
    MESSAGE(STATUS "NOT DEBUG mode")
    set(APG_COMMAND ${APG_BUILD_DIR}/apg)
endif()

set(APG_SOURCE_DIR "${APG_BUILD_DIR}/../src/apg")

ExternalProject_Add(apg    # Name for custom target
    #--Download step--------------
    GIT_REPOSITORY https://github.com/ldthomas/apg-6.3.git
    GIT_TAG master
    #--Update step----------------
    # Never update automatically from the remote repository
    UPDATE_DISCONNECTED 1
    #--Configure step-------------
    # set prefix to the default install dir
    # (apg-prefix in this case)
    CONFIGURE_COMMAND ${APG_PREFIX_DIR}/src/apg/configure ${APG_CONFIGURE_PARAMETER}
    #--Build step-----------------
    BINARY_DIR apg-prefix/build
    BUILD_COMMAND make
    BUILD_IN_SOURCE 0
    BUILD_ALWAYS 0
    #--Install step-----------------
    INSTALL_COMMAND ""
    #artifacts to use externally
    BUILD_BYPRODUCTS ${APG_OBJECT_FILES}
)

# due to possible aclocal/automake versions missmatch
# regenetate aclocal.m4 and Makefile.in
ExternalProject_Add_Step(apg regen-automake
    COMMAND aclocal
    COMMAND automake
    WORKING_DIRECTORY ${APG_SOURCE_DIR}
    COMMENT "Regenerating automake files..."
    DEPENDEES download
    DEPENDERS configure
)
