include(FetchContent)

FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/refs/tags/v1.17.0.zip
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)

# For Windows: prevent overriding main()
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

add_executable(unit_tests
  test_main.cpp
)

target_link_libraries(unit_tests
  gtest_main
)

target_include_directories(unit_tests
  PRIVATE ${PROJECT_SOURCE_DIR}/include
)

include(GoogleTest)
gtest_discover_tests(unit_tests)
