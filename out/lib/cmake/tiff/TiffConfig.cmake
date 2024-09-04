if(NOT "ON")
    # TODO: import dependencies
endif()

function(set_variable_from_rel_or_absolute_path var root rel_or_abs_path)
    if(IS_ABSOLUTE "${rel_or_abs_path}")
        set(${var} "${rel_or_abs_path}" PARENT_SCOPE)
    else()
        set(${var} "${root}/${rel_or_abs_path}" PARENT_SCOPE)
    endif()
endfunction()

# Tell the user project where to find our headers and libraries
get_filename_component(_DIR "${CMAKE_CURRENT_LIST_FILE}" ABSOLUTE)
get_filename_component(_DIR "${_DIR}" DIRECTORY)
get_filename_component(_ROOT "${_DIR}/" ABSOLUTE)
# Use _ROOT as prefix here for the possibility of relocation after installation.
set_variable_from_rel_or_absolute_path("TIFF_INCLUDE_DIR" "${_ROOT}" "include")
set(TIFF_INCLUDE_DIRS ${TIFF_INCLUDE_DIR})

set(TIFF_LIBRARIES TIFF::tiff)

message(STATUS "appending ${CMAKE_CURRENT_LIST_DIR}")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

find_package(ZZ REQUIRED)
message(STATUS "ZZ found")

find_package(ZLIB REQUIRED)
# find_package(Deflate)
find_package(lolzma REQUIRED)
find_package(JPEG REQUIRED)
find_package(CMath REQUIRED)

if(NOT TARGET TIFF::tiff)
    include("${_DIR}/TiffTargets.cmake")
endif()

unset (_ROOT)
unset (_DIR)
