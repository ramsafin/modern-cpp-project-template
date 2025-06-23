cmake_minimum_required(VERSION 3.20 FATAL_ERROR)
project(modern_cpp_project LANGUAGES CXX)

# Enable C++20 with strict enforcement
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile_commands.json for clangd and clang-tidy
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Targets
add_executable(${PROJECT_NAME}
  src/main.cpp
)
target_include_directories(${PROJECT_NAME}
  PRIVATE ${PROJECT_SOURCE_DIR}/include
)

# Optionally enable building unit tests
option(ENABLE_TESTING "Build tests" OFF)

if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()
