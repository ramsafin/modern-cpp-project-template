cmake_minimum_required(VERSION 3.20 FATAL_ERROR)
project(modern_cpp_project LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)  # For clang-tidy/IDE support

add_executable(${PROJECT_NAME}
  src/main.cpp
)
target_include_directories(${PROJECT_NAME}
  PRIVATE ${PROJECT_SOURCE_DIR}/include
)

# Tests
option(ENABLE_TESTING "Build tests" OFF)

if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()
