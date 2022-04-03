vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mathisloge/DiligentCore
    REF 4492b99b76b0f86812333ef08d7447f55fbf5030
    SHA512 c1852052ade77d97876cdcc560b9c46c4efb54e84f16fe22b3828de4fe7975f78be3a5247f574210af5ddc72a56bfcaebd2d274bc4360173fde850373bb447ce
    HEAD_REF vcpkg
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_PATH "${PYTHON3}" DIRECTORY)
vcpkg_add_to_path(${PYTHON3_PATH})

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DDILIGENT_BUILD_TESTS=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/DiligentCore)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
