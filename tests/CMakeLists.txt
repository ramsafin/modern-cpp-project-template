include(FetchContent)

# GoogleTest
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.17.0.zip
  DOWNLOAD_EXTRACT_TIMESTAMP true
)

# Disable GTest/GMock install targets
set(INSTALL_GTEST          OFF CACHE BOOL "" FORCE)
set(INSTALL_GMOCK          OFF CACHE BOOL "" FORCE)
set(INSTALL_GTEST_HEADERS  OFF CACHE BOOL "" FORCE)
set(INSTALL_GTEST_MAIN     OFF CACHE BOOL "" FORCE)
set(gtest_force_shared_crt ON  CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(googletest)

add_executable(unit_tests
  test_main.cpp
  test_library.cpp
)

target_link_libraries(unit_tests
  PRIVATE gtest_main ${PROJECT_NAME}::library
)

enable_strict_warnings(unit_tests)
enable_sanitizers(unit_tests)
enable_coverage(unit_tests)

include(GoogleTest)

gtest_discover_tests(unit_tests
  PROPERTIES FAIL_REGULAR_EXPRESSION "WARNING|ERROR"
)
