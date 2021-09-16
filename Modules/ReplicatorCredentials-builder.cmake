##
## Copyright (c) 2018-2021 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##

# create a replicator credentials

string(APPEND username ${USERNAME})
string(APPEND password ${PASSWORD})

message(STATUS "Processing replicator credentials info for ${PROJECT_NAME}...")
file(READ ${INPUT_DIR}/ReplicatorCredentials.cpp.in rcFile_temporary)
string(CONFIGURE "${rcFile_temporary}" rcFile_updated @ONLY)
file(WRITE ${OUTPUT_DIR}/ReplicatorCredentials.cpp.tmp "${rcFile_updated}")
execute_process(
    COMMAND ${CMAKE_COMMAND} -E copy_if_different
    ${OUTPUT_DIR}/ReplicatorCredentials.cpp.tmp ${OUTPUT_DIR}/ReplicatorCredentials.cpp
)
