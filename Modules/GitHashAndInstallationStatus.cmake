##
## Copyright (c) 2018-2021 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##
macro(get_git_hash_and_installation_status GIT_REPO_PATH LIB_INSTALLATION_PATH)
    find_package(Git)
    if(NOT Git_FOUND)
        message(FATAL_ERROR "'git' program not found")
    endif()

    if(${ARGC} GREATER 2)
        set(REF "remotes/origin/${ARGV2}")
    else()
        set(REF "HEAD")
    endif()

    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse --short=5 ${REF}
        WORKING_DIRECTORY ${GIT_REPO_PATH}
        OUTPUT_VARIABLE GIT_HASH
        RESULT_VARIABLE GIT_HASH_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(NOT ${GIT_HASH_RESULT} EQUAL 0)
        message(FATAL_ERROR "Failed to get git hash for ${GIT_REPO_PATH}\nGIT_HASH_RESULT: ${GIT_HASH_RESULT}")
    endif()

    # checks for header files in a given path
    file(GLOB_RECURSE LIB_INSTALLED ${LIB_INSTALLATION_PATH}-${GIT_HASH}/*.h)
endmacro()