##
## Copyright (c) 2018-2021 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##
macro(add_sds_plugin)
    set(options PROJ_NAME PLUGIN_OPTION_SUFFIX PLUGIN_NAME)
    cmake_parse_arguments(local "" "${options}" "" ${ARGN})

    target_sources(${local_PROJ_NAME} PRIVATE
        qml-dev-studio-plugin-${local_PLUGIN_NAME}-static.qrc
    )

    if(NOT APPS_CORESW_SDS OR NOT ${APPS_CORESW_SDS_PLUGIN_${local_PLUGIN_OPTION_SUFFIX}})
        if(EXISTS ${CMAKE_PLUGINS_OUTPUT_DIRECTORY}/sds-${local_PLUGIN_NAME}.rcc)
            message(STATUS "...removing 'sds-${local_PLUGIN_NAME}.rcc' plugin")
            file(REMOVE ${CMAKE_PLUGINS_OUTPUT_DIRECTORY}/sds-${local_PLUGIN_NAME}.rcc)
        endif()
    else()
        message(STATUS "Strata DevStudio plugin '${local_PLUGIN_NAME}'...")

        list(APPEND ${local_PROJ_NAME}_ENABLED_PLUGINS ${local_PLUGIN_NAME})

        set(PLUGIN_QRC_FILENAME qml-dev-studio-plugin-${local_PLUGIN_NAME}.qrc)
        add_custom_target(${local_PROJ_NAME}-plugin-${local_PLUGIN_NAME}
            SOURCES ${PLUGIN_QRC_FILENAME}
        )
        qt5_add_binary_resources(${local_PROJ_NAME}-plugin-${local_PLUGIN_NAME}-rcc
            ${PLUGIN_QRC_FILENAME}
            OPTIONS ARGS --compress 9 --threshold 0 --verbose
            DESTINATION ${CMAKE_PLUGINS_OUTPUT_DIRECTORY}/sds-${local_PLUGIN_NAME}.rcc
        )
        add_dependencies(${local_PROJ_NAME} ${local_PROJ_NAME}-plugin-${local_PLUGIN_NAME}-rcc)
    endif()
endmacro()
