include(FetchContent)

# Download and configure GoogleTest
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.17.0.zip
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE  # Prevents timestamp-related rebuild issues
)

FetchContent_MakeAvailable(googletest)

# === Unit Test Target ===
add_executable(unit_tests
  test_main.cpp
  test_arithmetic.cpp
)

target_link_libraries(unit_tests
  PRIVATE gtest_main arithmetic
)

enable_warnings(unit_tests)
enable_sanitizers(unit_tests)

# Automatically discover and register all test cases
include(GoogleTest)
gtest_discover_tests(unit_tests)
