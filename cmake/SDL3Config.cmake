# ****************************************************************************
#  Project:  LibCMaker
#  Purpose:  A CMake build scripts for build libraries with CMake
#  Author:   NikitaFeodonit, nfeodonit@yandex.com
# ****************************************************************************
#    Copyright (c) 2017-2026 NikitaFeodonit
#
#    This file is part of the LibCMaker project.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <http://www.gnu.org/licenses/>.
# ****************************************************************************


#-----------------------------------------------------------------------
# Library version
#

set(SDL3_VERSION "3.4.18" CACHE STRING "SDL3_VERSION")
set(SDL3_sha256
  "6962c6ef2bce74ae0222a05151404547bfb42e392bf564a7b0cf9b7e1f50f890"
  CACHE STRING "SDL3_sha256"
)


#-----------------------------------------------------------------------
# SDL3 options
#-----------------------------------------------------------------------

option(SDL_AUDIO "Enable the Audio subsystem" OFF)
# option(SDL_VIDEO "Enable the Video subsystem" OFF)
# option(SDL_GPU "Enable the GPU subsystem" OFF)  # Deps from SDL_VIDEO
# option(SDL_RENDER "Enable the Render subsystem" OFF)  # Deps from SDL_VIDEO
option(SDL_CAMERA "Enable the Camera subsystem" OFF)  # Deps from SDL_VIDEO
option(SDL_JOYSTICK "Enable the Joystick subsystem" OFF)
option(SDL_HAPTIC "Enable the Haptic subsystem" OFF)
option(SDL_HIDAPI "Enable the Hidapi subsystem" OFF)
# option(SDL_POWER "Enable the Power subsystem" OFF)
option(SDL_SENSOR "Enable the Sensor subsystem" OFF)
# option(SDL_DIALOG "Enable the Dialog subsystem" OFF)
# option(SDL_TRAY "Enable the Tray subsystem" OFF)

option(SDL_INSTALL             "Enable installation of SDL3" ON)
option(SDL_INSTALL_CPACK "Create binary SDL3 archive using CPack" OFF)
option(SDL_INSTALL_DOCS "Install docs for SDL3" OFF)
option(SDL_UNINSTALL           "Enable uninstallation of SDL3" ON)
option(SDL_PRESEED "Preseed CMake cache to speed up configuration" OFF)
option(SDL_RELOCATABLE "Create relocatable SDL package" OFF)

option(SDL_ANDROID_JAR  "Enable creation of SDL3.jar" ON)

set(SDL_ASSERTIONS "release" CACHE STRING "Enable internal sanity checks (auto/disabled/release/enabled/paranoid)")

option(SDL_TEST_LIBRARY   "Build the SDL3_test library" OFF)
option(SDL_TESTS           "Build the test directory" OFF)
option(SDL_INSTALL_TESTS   "Install test-cases" OFF)
option(SDL_TESTS_LINK_SHARED "link tests to shared SDL library" OFF)

option(SDL_EXAMPLES           "Build the examples directory" OFF)


#-----------------------------------------------------------------------
# Unpack, configure and build the required libraries
#-----------------------------------------------------------------------

find_package(Git 2.17.1 REQUIRED)

set(SDL3_SRC_NAME "SDL3-${SDL3_VERSION}")
set(SDL3_ARCHIVE_DIR "${CMAKE_CURRENT_LIST_DIR}/source")
set(SDL3_PATCH_DIR "${SDL3_ARCHIVE_DIR}/patch/${SDL3_SRC_NAME}")


include(FetchContent)

FetchContent_Declare(
  SDL3
  URL "${CMAKE_CURRENT_LIST_DIR}/source/${SDL3_SRC_NAME}.tar.xz"
  URL_HASH SHA256=${SDL3_sha256}
  OVERRIDE_FIND_PACKAGE
  PATCH_COMMAND
    ${GIT_EXECUTABLE} apply
      "${SDL3_PATCH_DIR}/CMake_various_fixes.patch"
)

FetchContent_MakeAvailable(SDL3)
