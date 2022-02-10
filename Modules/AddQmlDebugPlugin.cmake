##
## Copyright (c) 2018-2022 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##

macro(add_qml_debug_plugin)
    set(options PLUGIN_NAME)
    cmake_parse_arguments(local "" "${options}" "" ${ARGN})

    if(NOT APPS_PLUGINS_QMLDEBUG)
        if(EXISTS ${CMAKE_PLUGINS_OUTPUT_DIRECTORY}/${local_PLUGIN_NAME}.rcc)
            message(STATUS "...removing '${local_PLUGIN_NAME}.rcc'")
            file(REMOVE ${CMAKE_PLUGINS_OUTPUT_DIRECTORY}/${local_PLUGIN_NAME}.rcc)
        endif()

    else()
        set(PLUGIN_QRC_FILENAME ${SGDEBUG_DIR}/qml-plugin-${local_PLUGIN_NAME}.qrc)

        add_custom_target(plugin-${local_PLUGIN_NAME}-qrc
            SOURCES ${PLUGIN_QRC_FILENAME}
        )
        qt5_add_binary_resources(plugin-${local_PLUGIN_NAME}-rcc
            ${PLUGIN_QRC_FILENAME}
            OPTIONS ARGS --compress 9 --threshold 0 --verbose
            DESTINATION ${CMAKE_PLUGINS_OUTPUT_DIRECTORY}/${local_PLUGIN_NAME}.rcc
        )
    endif()

endmacro()

macro(add_qml_debug_plugin_to_version)
    set(options PROJ_NAME PLUGIN_NAME)
    cmake_parse_arguments(local "" "${options}" "" ${ARGN})

    message(STATUS "Qml Debug plugin '${local_PLUGIN_NAME}' for '${local_PROJ_NAME}'...")

    list(APPEND ${local_PROJ_NAME}_ENABLED_PLUGINS ${local_PLUGIN_NAME})

endmacro()
