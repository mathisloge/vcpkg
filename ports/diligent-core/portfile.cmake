vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mathisloge/DiligentCore
    REF 9bc23b3840e025084e3e017d81f0cb437c54640d #v3.18.00
    SHA512 3e5d97a77b8610a2efdb9156b47c91e8a8dd5629ff95ea6d2c65016b067ab645df5beddc8c7f93d89c3d1a6f404ff71282efc6db9885a6e6240fa444fe2be79c
    HEAD_REF vcpkg
    PATCHES 
        fix_cmake_install.patch
        Fix-error-C2338.patch
)
