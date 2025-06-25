add_library(arithmetic STATIC
  arithmetic.cpp
)

target_include_directories(arithmetic
  PUBLIC ${PROJECT_SOURCE_DIR}/include
)

enable_lto(arithmetic)
enable_sanitizers(arithmetic)
enable_strict_warnings(arithmetic)
