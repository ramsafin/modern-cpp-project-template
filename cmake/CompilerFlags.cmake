#–– CompilerFlags.cmake –– central cache of all compiler‐flag lists

# Compiler warnings
set(PROJECT_WARNING_FLAGS
  -Wall -Wextra -Wpedantic -Wconversion -Wsign-conversion
  CACHE STRING "Compiler warning flags"
)

# Sanitizers
set(PROJECT_ASAN_FLAGS   "-fsanitize=address"    CACHE STRING "AddressSanitizer flags")
set(PROJECT_UBSAN_FLAGS  "-fsanitize=undefined"  CACHE STRING "UndefinedBehaviorSanitizer flags")

# Coverage
set(PROJECT_COVERAGE_FLAGS "--coverage"
  CACHE STRING "Coverage instrumentation flags"
)
