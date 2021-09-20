##
## Copyright (c) 2018-2021 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##
macro(add_view)
    set(projectName NAME)
    cmake_parse_arguments(local "" "${projectName}" "" ${ARGN})

    cmake_dependent_option(APPS_VIEWS_${local_NAME} "Strata '${local_NAME}' view" ON
                           "APPS_VIEWS" OFF)
                       add_feature_info(APPS_VIEWS-${local_NAME} APPS_VIEWS_${local_NAME} "Strata '${local_NAME}' view")

    if(NOT APPS_VIEWS OR NOT ${APPS_VIEWS_${local_NAME}})
        if(EXISTS ${CMAKE_VIEWS_OUTPUT_DIRECTORY}/views-${local_NAME}.rcc)
            message(STATUS "...removing 'views-${local_NAME}.rcc'")
            file(REMOVE ${CMAKE_VIEWS_OUTPUT_DIRECTORY}/views-${local_NAME}.rcc)
        endif()

        # update/remove QML mobule import path for this project here
        remove_qml_import_path(PATH "${CMAKE_CURRENT_SOURCE_DIR}")
    else()
        message(STATUS "Strata view '${local_NAME}'...")

        file(GLOB_RECURSE QRC_SRCS ${CMAKE_CURRENT_SOURCE_DIR}/qml-*.qrc)
        list(APPEND QRC_SRCS "${CMAKE_CURRENT_BINARY_DIR}/version.qrc")

        add_custom_target(views-${local_NAME}_qrcs SOURCES ${QRC_SRCS} version.json)
        qt5_add_binary_resources(views-${local_NAME}
            ${QRC_SRCS}
            OPTIONS ARGS --compress 9 --threshold 0 --verbose
            DESTINATION ${CMAKE_VIEWS_OUTPUT_DIRECTORY}/views-${local_NAME}.rcc
        )

        set(PROJECT_NAME views-${local_NAME})
        generate_component_version(GITTAG_PREFIX ${local_NAME}_ QRC_NAMESPACE "/views")

        # [LC] update QML mobule import paths for this project here
        add_qml_import_path(PATH "${CMAKE_CURRENT_SOURCE_DIR}")
    endif()
endmacro()
