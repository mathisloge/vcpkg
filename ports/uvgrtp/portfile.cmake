vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mathisloge/uvgRTP
    REF "8a976f07a9aa6e356509e0f0e7253175a837adfa"
    SHA512 7ad6f9e5c7368fc2553f9989c32994386a173204b4a061f178a4915540b4c1af5dd58e5e107c623a493c7e24f2dcfaa731324ba6429348d744aa7b3a3ca8271a
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DUVGRTP_DISABLE_TESTS=ON
        -DUVGRTP_DISABLE_EXAMPLES=ON
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/uvgrtp)
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")
#file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
