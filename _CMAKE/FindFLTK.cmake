# Locate FLTK
#
# This module defines
# FLTK_LIBRARIES - Link to this, by default it includes all release libs
# FLTK_LIBRARIES_DEBUG - Link to this, by default it includes all debug libs
# FLTK_FOUND, if false, do not try to link to FLTK
# FLTK_INCLUDE_DIRS, where to find the headers
#
#  This module accepts the following variables
#
#  FLTK_ROOT_DIR - Can be set to FLTK install path or Windows build path
#
# Created by Robert Hauck / Urs Kuenzler 



# locate architecture dependent static library files
if(CMAKE_GENERATOR MATCHES "Win64")
    #message("FLTK x64 mode")
    set(ARCH_LIBRARY_PATH "${FLTK_ROOT_DIR}/lib/x64")
else()    
    #message("FLTK x86 mode")
    set(ARCH_LIBRARY_PATH "${FLTK_ROOT_DIR}/lib/x86")
endif(CMAKE_GENERATOR MATCHES "Win64")

find_library(FLTK_LIBRARY          NAMES fltk             PATHS "${ARCH_LIBRARY_PATH}/Release" ${CMAKE_LIBRARY_PATH} PATH_SUFFIXES lib)
find_library(FLTK_LIBRARY_DEBUG    NAMES fltkd fltk       PATHS "${ARCH_LIBRARY_PATH}/Debug"   ${CMAKE_LIBRARY_PATH} PATH_SUFFIXES lib)
find_library(FLTK_GL_LIBRARY       NAMES fltk_gl          PATHS "${ARCH_LIBRARY_PATH}/Release" ${CMAKE_LIBRARY_PATH} PATH_SUFFIXES lib)
find_library(FLTK_GL_LIBRARY_DEBUG NAMES fltk_gld fltk_gl PATHS "${ARCH_LIBRARY_PATH}/Debug"   ${CMAKE_LIBRARY_PATH} PATH_SUFFIXES lib)


# locate header files and put user specified location at beginning of search
if(FLTK_ROOT_DIR)
    set(_FLTK_HEADER_SEARCH_DIRS "${FLTK_ROOT_DIR}"
                                "${FLTK_ROOT_DIR}/include"
                                 ${_FLTK_HEADER_SEARCH_DIRS})
endif(FLTK_ROOT_DIR)

find_path(FLTK_INCLUDE_DIR "FL/glut.H" PATHS ${_FLTK_HEADER_SEARCH_DIRS})


# find local FLTK (specific to OS X)
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
   set(FLTK_ROOT_DIR ${CMAKE_SOURCE_DIR}/_LIBS/FLTK)
   
   set(FLTK_INCLUDE_DIR ${FLTK_ROOT_DIR}/include)
   
   set(FLTK_LIBRARIES_PATH ${FLTK_ROOT_DIR}/lib)

   set(FLTK_LIBRARY ${FLTK_LIBRARIES_PATH}/libfltk.a) 
   set(FLTK_GL_LIBRARY ${FLTK_LIBRARIES_PATH}/libfltk_gl.a)

   set(FLTK_LIBRARY_DEBUG ${FLTK_LIBRARIES_PATH}/libfltkd.a) 
   set(FLTK_GL_LIBRARY_DEBUG ${FLTK_LIBRARIES_PATH}/libfltk_gld.a)
endif()


# handle the QUIETLY and REQUIRED arguments and set FLTK_FOUND to TRUE if all listed variables are TRUE
include("FindPackageHandleStandardArgs")
FIND_PACKAGE_HANDLE_STANDARD_ARGS(FLTK DEFAULT_MSG FLTK_LIBRARY FLTK_LIBRARY_DEBUG FLTK_INCLUDE_DIR)

if(FLTK_FOUND)
   set(FLTK_INCLUDE_DIRS ${FLTK_INCLUDE_DIR})
   set(FLTK_LIBRARIES ${FLTK_LIBRARY} ${FLTK_GL_LIBRARY})
   set(FLTK_LIBRARIES_DEBUG ${FLTK_LIBRARY_DEBUG} ${FLTK_GL_LIBRARY_DEBUG})
endif(FLTK_FOUND)