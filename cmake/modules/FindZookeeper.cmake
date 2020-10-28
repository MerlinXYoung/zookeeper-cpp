# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindZookeeper
-------

Finds the Zookeeper library.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

``Zookeeper::st``
  The Zookeeper_st library

``Zookeeper::mt``
  The Zookeeper_mt library

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``Zookeeper_FOUND``
  True if the system has the Zookeeper library.
# ``Zookeeper_VERSION``
#   The version of the Zookeeper library which was found.
``Zookeeper_INCLUDE_DIRS``
  Include directories needed to use Zookeeper.
``Zookeeper_LIBRARIES``
  Libraries needed to link to Zookeeper.

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``Zookeeper_INCLUDE_DIR``
  The directory containing ``Zookeeper.h``.
``Zookeeper_LIBRARY``
  The path to the Zookeeper library.

HINTS
^^^^^
Zookeeper_DIR
Where to find the base directory of Zookeeper.

#]=======================================================================]
find_path(Zookeeper_INCLUDE_DIR
    NAMES zookeeper/zookeeper.h zookeeper/zookeeper_version.h
    # PATHS /usr/include /usr/local/include ${Zookeeper_DIR}/include
    HINTS ${Zookeeper_DIR}/include
    # PATH_SUFFIXES Zookeeper
)

file(READ ${Zookeeper_INCLUDE_DIR}/zookeeper/zookeeper_version.h VERSION_HPP_STR)
string(REGEX REPLACE ".*# *define +ZOO_MAJOR_VERSION +([0-9]+).*" "\\1" Zookeeper_VERSION_MAJOR "${VERSION_HPP_STR}")
string(REGEX REPLACE ".*# *define +ZOO_MINOR_VERSION +([0-9]+).*" "\\1" Zookeeper_VERSION_MINOR "${VERSION_HPP_STR}")
string(REGEX REPLACE ".*# *define +ZOO_PATCH_VERSION +([0-9]+).*" "\\1" Zookeeper_VERSION_PATCH "${VERSION_HPP_STR}")

set(Zookeeper_VERSION "${Zookeeper_VERSION_MAJOR}.${Zookeeper_VERSION_MINOR}.${Zookeeper_VERSION_PATCH}")

find_library(Zookeeper_MT_LIBRARY
    zookeeper_mt
    PATHS /usr/lib /usr/local/lib ${Zookeeper_DIR}/lib
)

find_library(Zookeeper_ST_LIBRARY
    zookeeper_st
    PATHS /usr/lib /usr/local/lib ${Zookeeper_DIR}/lib
)

if(Zookeeper_ST_LIBRARY)
    set(Zookeeper_LIBRARY ${Zookeeper_ST_LIBRARY})
    set(Zookeeper_ST_FOUND true)
endif()

if(Zookeeper_MT_LIBRARY)
    set(Zookeeper_LIBRARY ${Zookeeper_MT_LIBRARY})
    set(Zookeeper_MT_FOUND true)
endif()


include( FindPackageHandleStandardArgs )
message(STATUS "${Zookeeper_INCLUDE_DIR} ${Zookeeper_LIBRARY}")

# find_package_handle_standard_args(Zookeeper  
#     DEBAULT_MSG
#     Zookeeper_INCLUDE_DIR Zookeeper_LIBRARY Zookeeper_VERSION
# ) 

message(STATUS "${Zookeeper_FIND_COMPONENTS}") 
find_package_handle_standard_args(Zookeeper  
    FOUND_VAR Zookeeper_FOUND
    REQUIRED_VARS Zookeeper_INCLUDE_DIR Zookeeper_LIBRARY
    VERSION_VAR Zookeeper_VERSION
    HANDLE_COMPONENTS 
#   [CONFIG_MODE]
    FAIL_MESSAGE "Can't Find Zookeeper ! "
) 


if(Zookeeper_FOUND)
    message(STATUS "Zookeeper:${Zookeeper_INCLUDE_DIR}")
    set(Zookeeper_LIBRARIES ${Zookeeper_LIBRARY})
    set(Zookeeper_INCLUDE_DIRS ${Zookeeper_INCLUDE_DIR})
    # set(Zookeeper_DEFINITIONS ${PC_Zookeeper_CFLAGS_OTHER})
    mark_as_advanced(
    Zookeeper_INCLUDE_DIR
    Zookeeper_LIBRARY
    )
endif()

if(Zookeeper_FOUND )
  if(NOT TARGET Zookeeper::MT)
    add_library(Zookeeper::MT UNKNOWN IMPORTED)
    set_target_properties(Zookeeper::MT PROPERTIES
        IMPORTED_LOCATION "${Zookeeper_MT_LIBRARY}"
        # INTERFACE_COMPILE_OPTIONS "${PC_Zookeeper_CFLAGS_OTHER}"
        INTERFACE_INCLUDE_DIRECTORIES "${Zookeeper_INCLUDE_DIR}"
    )
  endif()
  if(NOT TARGET Zookeeper::ST)
    add_library(Zookeeper::ST UNKNOWN IMPORTED)
    set_target_properties(Zookeeper::ST PROPERTIES
        IMPORTED_LOCATION "${Zookeeper_ST_LIBRARY}"
        # INTERFACE_COMPILE_OPTIONS "${PC_Zookeeper_CFLAGS_OTHER}"
        INTERFACE_INCLUDE_DIRECTORIES "${Zookeeper_INCLUDE_DIR}"
    )
  endif()
endif()


# if(Zookeeper_FOUND)
#   if (NOT TARGET Zookeeper::Zookeeper)
#     add_library(Zookeeper::Zookeeper UNKNOWN IMPORTED)
#   endif()
#   if (Zookeeper_LIBRARY_RELEASE)
#     set_property(TARGET Zookeeper::Zookeeper APPEND PROPERTY
#       IMPORTED_CONFIGURATIONS RELEASE
#     )
#     set_target_properties(Zookeeper::Zookeeper PROPERTIES
#       IMPORTED_LOCATION_RELEASE "${Zookeeper_LIBRARY_RELEASE}"
#     )
#   endif()
#   if (Zookeeper_LIBRARY_DEBUG)
#     set_property(TARGET Zookeeper::Zookeeper APPEND PROPERTY
#       IMPORTED_CONFIGURATIONS DEBUG
#     )
#     set_target_properties(Zookeeper::Zookeeper PROPERTIES
#       IMPORTED_LOCATION_DEBUG "${Zookeeper_LIBRARY_DEBUG}"
#     )
#   endif()
#   set_target_properties(Zookeeper::Zookeeper PROPERTIES
#     # INTERFACE_COMPILE_OPTIONS "${PC_Zookeeper_CFLAGS_OTHER}"
#     INTERFACE_INCLUDE_DIRECTORIES "${Zookeeper_INCLUDE_DIR}"
#   )
# endif()