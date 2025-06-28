add_library(math STATIC
  arithmetic.cpp
)

add_library(${PROJECT_NAME}::math ALIAS math)

target_include_directories(math
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

enable_coverage(math)

enable_lto(math)
enable_sanitizers(math)
enable_strict_warnings(math)
