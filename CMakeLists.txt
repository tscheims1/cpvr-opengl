#Build list of all CG project directories

cmake_minimum_required(VERSION 2.8)

project(CG-PROJECTS)


#Assume Debug builds as default
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()


# setup CMAKE default search paths
set(SOURCE_DIR .)
set(CMAKE_PREFIX_PATH "${CMAKE_HOME_DIRECTORY}/_LIBS;${CMAKE_PREFIX_PATH}")
set(CMAKE_MODULE_PATH "${CMAKE_HOME_DIRECTORY}/_CMAKE;${CMAKE_MODULE_PATH}")


# macro to force the build directory to be different from source directory
include(MACRO_ENSURE_OUT_OF_SOURCE_BUILD)
ENSURE_OUT_OF_SOURCE_BUILD("${PROJECT_NAME} requires an out of source build.")


# macro to to loop over all project directories
include(MACRO_GET_DIRECTORIES)
GET_DIRECTORIES(PROJECTS CG-* ${SOURCE_DIR})


# set platform type here (get OS X)
if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  set(APPLE TRUE)
  # we fix the min. deployment target platform version 
  # (for convenience reasons) in the project settings of Xcode
  set(CMAKE_OSX_DEPLOYMENT_TARGET 10.9)
else()
  set(APPLE FALSE)   
endif()


# process found applications
foreach(PROJECT ${PROJECTS})
	if(EXISTS ${PROJECT})
		add_subdirectory(${PROJECT})
	endif(EXISTS ${PROJECT})
endforeach(PROJECT ${PROJECTS})
