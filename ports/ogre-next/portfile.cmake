if (EXISTS "${CURRENT_INSTALLED_DIR}/Media/HLMS/Blendfunctions_piece_fs.glslt")
    message(FATAL_ERROR "FATAL ERROR: ogre-next and ogre are incompatible.")
endif()

if(NOT VCPKG_TARGET_IS_WINDOWS)
    message("${PORT} currently requires the following library from the system package manager:\n    Xaw\n\nIt can be installed on Ubuntu systems via apt-get install libxaw7-dev")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO OGRECave/ogre-next
    REF f8f59465a55d7cb812b8a568b913dad77890ef4a
    SHA512 97f7b486349cb52b36902af19ca371ddbf9112b9d3bed8312387bbef4245cb97d6e3d445b6b8403e9fddaa97ebcc9e080af4b1a32e5267bcb10c2a83c7e9acf9
    HEAD_REF master
    PATCHES 
        cmake-dir.patch
)

file(REMOVE "${SOURCE_PATH}/CMake/Packages/FindOpenEXR.cmake")

set(OGRE_STATIC OFF)
if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    set(OGRE_STATIC ON)
endif()

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        "vulkan"                OGRE_BUILD_RENDERSYSTEM_VULKAN
        "d3d11"                 OGRE_BUILD_RENDERSYSTEM_D3D11 
        "plugin-pfx"            OGRE_BUILD_PLUGIN_PFX
        "mesh-lod-generator"    OGRE_BUILD_COMPONENT_MESHLODGENERATOR
        "planar-reflections"    OGRE_BUILD_COMPONENT_PLANAR_REFLECTIONS
        #"property"              OGRE_BUILD_COMPONENT_PROPERTY # currently has build failures
        "overlay"               OGRE_BUILD_COMPONENT_OVERLAY
        "tools"                 OGRE_BUILD_TOOLS
        "xsi-exporter"          OGRE_BUILD_XSIEXPORTER
        "samples"               OGRE_BUILD_SAMPLES2
)
vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DOGRE_INSTALL_DEPENDENCIES=OFF
        -DOGRE_COPY_DEPENDENCIES=OFF
        -DOGRE_BUILD_TESTS=OFF
        -DOGRE_STATIC=${OGRE_STATIC}
        -DOGRE_INSTALL_DOCS=OFF
        -DOGRE_INSTALL_SAMPLES_SOURCE=OFF
        -DOGRE_RUNTIME_OUTPUT="bin"
        -DOGRE_LIBRARY_OUTPUT="lib"
        -DOGRE_ARCHIVE_OUTPUT="lib"
        -DOGRE_INSTALL_PDB=OFF
# vcpkg specific stuff
        -DOGRE_CMAKE_DIR=share/OGRE
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_cmake_config_fixup(PACKAGE_NAME OGRE)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
