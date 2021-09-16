##
## Copyright (c) 2018-2021 onsemi.
##
## All rights reserved. This software and/or documentation is licensed by onsemi under
## limited terms and conditions. The terms and conditions pertaining to the software and/or
## documentation are available at http://www.onsemi.com/site/pdf/ONSEMI_T&C.pdf (“onsemi Standard
## Terms and Conditions of Sale, Section 8 Software”).
##
macro(add_qml_import_path)
    set(qmlImportPath PATH)
    cmake_parse_arguments(local "" "${qmlImportPath}" "" ${ARGN})

    if(NOT ${local_PATH} IN_LIST QML_IMPORT_PATH)
        set(QML_DIRS "${QML_IMPORT_PATH}")
        LIST(APPEND QML_DIRS ${local_PATH})

        # Additional import path used to resolve QML modules in Qt Creator's code model
        set(QML_IMPORT_PATH "${QML_DIRS}" CACHE STRING "Qt Creator extra qml import paths" FORCE)
        message(STATUS "...updated QML import path with: '${local_PATH}'")
    endif()
endmacro()

macro(remove_qml_import_path)
    set(qmlImportPath PATH)
    cmake_parse_arguments(local "" "${qmlImportPath}" "" ${ARGN})

    if(${local_PATH} IN_LIST QML_IMPORT_PATH)
        list(REMOVE_ITEM QML_IMPORT_PATH ${local_PATH})

        # Additional import path used to resolve QML modules in Qt Creator's code model
        set(QML_IMPORT_PATH "${QML_DIRS}" CACHE STRING "Qt Creator extra qml import paths" FORCE)
        message(STATUS "...removed QML import path: '${local_PATH}'")
    endif()
endmacro()
