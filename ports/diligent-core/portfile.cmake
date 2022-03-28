vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO mathisloge/DiligentCore
  REF 63efbd507986156ac550c5481d4d8e978867947f
  SHA512 3de2d2c5f81d697853dc671e2bd3f2b8312df9ca5d85173a6878661f6096a84c952d969b5be97b8c08bf5eadd6297c2cdb42109e0985316962755ee168bc7739
  HEAD_REF master
)


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DDILIGENT_USE_BUNDLED_DEPENDENCIES=OFF
        -DDILIGENT_NO_FORMAT_VALIDATION=ON
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()
