vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mathisloge/DiligentCore
    REF c2f68118a3f64e069ffbc15c7ad9d64fb96d5454
    SHA512 a7b51d396d968b5eb4cec0a58a4e5e2b1c1a623d86a5b553a0987c13759c17870d049b9afbfbb9d029d605d5fbb5dd26f435b4ea6bbd5866cd086bd777726dd9
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

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
