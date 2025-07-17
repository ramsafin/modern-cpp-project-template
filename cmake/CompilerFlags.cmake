#–– CompilerFlags.cmake –– central cache of all compiler‐flag lists

# Compiler warnings
set(PROJECT_WARNING_FLAGS
  -Wall
  -Wextra
  -Wpedantic
  -Wconversion
  -Wsign-conversion
)

# Sanitizers
set(PROJECT_ASAN_FLAGS -fsanitize=address)
set(PROJECT_UBSAN_FLAGS -fsanitize=undefined)

# Coverage
set(PROJECT_COVERAGE_FLAGS --coverage)
