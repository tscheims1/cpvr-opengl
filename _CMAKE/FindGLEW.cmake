# Locate GLEW
#
# This module defines
# GLEW_LIBRARIES - Link to this, by default it includes all release libs
# GLEW_LIBRARIES_DEBUG - Link to this, by default it includes all debug libs
# GLEW_FOUND, if false, do not try to link to Freeglut
# GLEW_INCLUDE_DIRS, where to find the headers
#
#  This module accepts the following variables
#
#  GLEW_ROOT_DIR - Can be set to Freeglut install path or Windows build path
#
# Created by Robert Hauck / Urs Kuenzler 



# locate architecture dependent static library files
if(CMAKE_GENERATOR MATCHES "Win64")
    #message("GLEW x64 mode")
    set(ARCH_LIBRARY_PATH "${GLEW_ROOT_DIR}/lib/x64")
else()    
    #message("GLEW x86 mode")
    set(ARCH_LIBRARY_PATH "${GLEW_ROOT_DIR}/lib/x86")
endif(CMAKE_GENERATOR MATCHES "Win64")

find_library(GLEW_LIBRARY       NAMES GLEW libglew32            PATHS "${ARCH_LIBRARY_PATH}/Release" ${CMAKE_LIBRARY_PATH} PATH_SUFFIXES lib)
find_library(GLEW_LIBRARY_DEBUG NAMES GLEW libglew32d libglew32 PATHS "${ARCH_LIBRARY_PATH}/Debug"   ${CMAKE_LIBRARY_PATH} PATH_SUFFIXES lib)


# locate header files and put user specified location at beginning of search
if(GLEW_ROOT_DIR)
    set(_GLEW_HEADER_SEARCH_DIRS "${GLEW_ROOT_DIR}"
                                "${GLEW_ROOT_DIR}/include"
                                 ${_GLEW_HEADER_SEARCH_DIRS})
endif(GLEW_ROOT_DIR)

find_path(GLEW_INCLUDE_DIR "GL/glew.h" PATHS ${_GLEW_HEADER_SEARCH_DIRS})


# find local GLEW (specific to OS X)
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
   set(GLEW_ROOT_DIR ${CMAKE_SOURCE_DIR}/_LIBS/GLEW)
   
   set(GLEW_INCLUDE_DIR ${GLEW_ROOT_DIR}/include)
   set(GLEW_LIBRARIES_PATH ${GLEW_ROOT_DIR}/lib)
      
   set(GLEW_LIBRARY ${GLEW_LIBRARIES_PATH}/libGLEW.a)

   set(GLEW_LIBRARY_DEBUG ${GLEW_LIBRARIES_PATH}/libGLEWd.a)
endif()


# handle the QUIETLY and REQUIRED arguments and set GLEW_FOUND to TRUE if all listed variables are TRUE
include("FindPackageHandleStandardArgs")
FIND_PACKAGE_HANDLE_STANDARD_ARGS(GLEW DEFAULT_MSG GLEW_LIBRARY GLEW_LIBRARY_DEBUG GLEW_INCLUDE_DIR)

if(GLEW_FOUND)
   set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDE_DIR})
   set(GLEW_LIBRARIES ${GLEW_LIBRARY})
   set(GLEW_LIBRARIES_DEBUG ${GLEW_LIBRARY_DEBUG})
endif(GLEW_FOUND)