##
## Copyright (c) 2018-2022 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##
function(find_all_config_files PATHS_LIST FILE_PATTERN FILE_LIST)
    foreach(CONFIG_PATH IN LISTS PATHS_LIST)
        file(GLOB TEMP_LIST
            RELATIVE ${CONFIG_PATH}
            ${CONFIG_PATH}/${FILE_PATTERN}
        )
        list(APPEND TEMP_FILES_LIST ${TEMP_LIST})
    endforeach()
    set(${FILE_LIST} ${TEMP_FILES_LIST} PARENT_SCOPE)
endfunction(find_all_config_files)

function(deploy_config_file PATHS_LIST CONFIG_FILE_NAME TARGET_CONFIG_NAME)
    find_file(CONFIG_ABSOLUTE_PATH 
        NAMES "${CONFIG_FILE_NAME}"
        PATHS ${PATHS_LIST}
        NO_DEFAULT_PATH
        REQUIRED
    )

    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
        ${CONFIG_ABSOLUTE_PATH}
        $<TARGET_FILE_DIR:${PROJECT_NAME}>/${TARGET_CONFIG_NAME}
        COMMENT "Deploying '${CONFIG_FILE_NAME}' as '${TARGET_CONFIG_NAME}'..."
        VERBATIM
    )
    unset(CONFIG_ABSOLUTE_PATH CACHE)
endfunction(deploy_config_file)
