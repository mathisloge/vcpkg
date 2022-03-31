vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO mathisloge/DiligentCore
  REF 269155c857aad0354d27234ec78d407488d00e7a
  SHA512 49751017d9c1932762a14c38c3f779e557caaac4bf2e3490ac13c2be6e0d22cf605aa47c5e48f523c8b3743d4efae9f1050b9e1ec67ad2dace68049ef82ec2a4
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
