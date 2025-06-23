cmake_minimum_required(VERSION 3.20 FATAL_ERROR)
project(modern_cpp_project LANGUAGES CXX)

# Enable C++20 with strict enforcement
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile_commands.json for clangd and clang-tidy
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Sanitizer options
option(ENABLE_ASAN "Enable AddressSanitizer" ON)
option(ENABLE_UBSAN "Enable UndefinedBehaviorSanitizer" ON)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(Sanitizers)

# Targets
add_executable(${PROJECT_NAME}
  src/main.cpp
)

target_include_directories(${PROJECT_NAME}
  PRIVATE ${PROJECT_SOURCE_DIR}/include
)

if(TARGET sanitizers)
  target_link_libraries(${PROJECT_NAME} PRIVATE sanitizers)
endif()

# Testing options
option(ENABLE_TESTING "Build tests" ON)

if(ENABLE_TESTING)
  message(STATUS "Enabled unit tests")
  enable_testing()
  add_subdirectory(tests)
endif()
