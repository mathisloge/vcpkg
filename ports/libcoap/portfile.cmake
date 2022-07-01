if (VCPKG_TARGET_IS_WINDOWS)
    vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO obgm/libcoap
    REF dc92fe5e1ea62365636d4555bfedafa4da4a0858
    SHA512 09c47d96193c34fc1ec3175c874033f6e953d396532570d5f3048bca5e23133947ad3c3c49d589c1653e3d90b724e369f29e4a89bdcb91153d9cf778140576c1
    HEAD_REF develop
    PATCHES fix-win-stat.patch
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        epoll    WITH_EPOLL
        tcp      ENABLE_TCP
        examples ENABLE_EXAMPLES
        dtls     ENABLE_DTLS
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        ${FEATURE_OPTIONS}
        -DENABLE_TESTS=OFF
        -DENABLE_DOCS=OFF
        -DDTLS_BACKEND=openssl
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/libcoap)
vcpkg_copy_pdbs()

if("examples" IN_LIST FEATURES)
    vcpkg_copy_tools(
        TOOL_NAMES coap-client coap-server coap-rd
        AUTO_CLEAN
    )
endif()

file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/include"
)
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
