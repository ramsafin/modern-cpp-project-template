add_library(arithmetic STATIC
  arithmetic.cpp
)

target_include_directories(arithmetic
  PUBLIC ${PROJECT_SOURCE_DIR}/include
)

enable_strict_warnings(arithmetic)
target_link_with_sanitizers(arithmetic)
