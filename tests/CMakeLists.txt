include(FetchContent)

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.17.0.zip
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE  # Prevents timestamp-related rebuild issues
)

# Windows-specific: avoid CRT conflicts
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(googletest)

# Unit tests
add_executable(unit_tests
  main.cpp
  test_core.cpp
  test_sanitizers.cpp
)

target_link_libraries(unit_tests
  PRIVATE gtest_main
)

target_include_directories(unit_tests
  PRIVATE ${PROJECT_SOURCE_DIR}/include
)

if(TARGET sanitizers)
  message(STATUS "Enabled sanitizers for unit tests")
  target_link_libraries(unit_tests PRIVATE sanitizers)
endif()

# Automatically discover and register all test cases
include(GoogleTest)
gtest_discover_tests(unit_tests)
