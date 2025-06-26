add_library(math STATIC
  arithmetic.cpp
)

target_include_directories(math
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

enable_lto(math)
enable_sanitizers(math)
enable_strict_warnings(math)
