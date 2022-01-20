##
## Copyright (c) 2018-2022 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##

# create a build timestamp for non-debug builds only

# TODO: add MSVC/Xcode support
if(NOT "${BUILD_TYPE}" STREQUAL "Debug")
    string(TIMESTAMP formattedTimestamp UTC)
    message(STATUS "Timestamp for ${PROJECT_NAME}: ${formattedTimestamp}")
else()
    string(TIMESTAMP formattedTimestamp "N/A (debug build)")
    message(STATUS "Timestamp for ${PROJECT_NAME}: N/A ('${BUILD_TYPE}' build)")
endif()

cmake_host_system_information(RESULT hostName QUERY HOSTNAME)

message(STATUS "Processing build timestamp info...")
file(READ ${INPUT_DIR}/Timestamp.cpp.in tsFile_temporary)
string(CONFIGURE "${tsFile_temporary}" tsFile_updated @ONLY)
file(WRITE ${OUTPUT_DIR}/Timestamp.cpp.tmp "${tsFile_updated}")
execute_process(
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${OUTPUT_DIR}/Timestamp.cpp.tmp ${OUTPUT_DIR}/Timestamp.cpp
)
