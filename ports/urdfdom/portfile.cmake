vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO ros/urdfdom
  REF 3.0.0
  SHA512 1fa3372d5beed6b119444ef99d50991a417d42bc7a3152e4697dc26e1bd1e351d45edd4c56f9dfff6f2c8480b3f43c6dfe246d22890db0f676d68591a5c0aaf6
  HEAD_REF master
)

vcpkg_cmake_configure(
  SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()

vcpkg_copy_tools(
  TOOL_NAMES "check_urdf" "urdf_mem_test" "urdf_to_graphviz" 
  AUTO_CLEAN
)

vcpkg_copy_pdbs()

if(VCPKG_TARGET_IS_WINDOWS)
    vcpkg_cmake_config_fixup(CONFIG_PATH CMake)
else()
    vcpkg_cmake_config_fixup(CONFIG_PATH lib/urdfdom/cmake)
    # Empty folders
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/urdfdom")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/urdfdom")
endif()

vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include" "${CURRENT_PACKAGES_DIR}/debug/share")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
