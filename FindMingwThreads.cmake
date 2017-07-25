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
## @brief      Extra cmake messages
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

# mingw-std-threads
if(CMAKE_CROSSCOMPILING AND WIN32)

	ExternalProject_Add(mingw-std-threads
		GIT_REPOSITORY https://github.com/meganz/mingw-std-threads.git
		GIT_TAG master
		UPDATE_DISCONNECTED 1
		CONFIGURE_COMMAND ""
		BUILD_COMMAND ""
		BUILD_ALWAYS 0
		INSTALL_COMMAND ""
	)

	ExternalProject_Get_Property(mingw-std-threads source_dir)
	message(STATUS "mingw-std-threads location: ${source_dir}")

	set_target_properties(mingw-std-threads PROPERTIES
		INTERFACE_INCLUDE_DIRECTORIES ${source_dir}
	)

endif()
