cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
project(modern_cpp_project LANGUAGES CXX)

# Enable C++20 with strict enforcement
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile_commands.json for clangd and clang-tidy
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Options
option(ENABLE_TESTING "Build tests" ON)

# Add custom "Sanitize" build type
if(CMAKE_CONFIGURATION_TYPES)
  list(APPEND CMAKE_CONFIGURATION_TYPES Sanitize)
  list(REMOVE_DUPLICATES CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING "" FORCE)
endif()

# Load cmake modules: sanitizers, warnings, lto
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

include(Sanitizers)
include(Warnings)
include(LTO)

# === Libraries ===
add_subdirectory(src)

# === Application target ===
add_executable(${PROJECT_NAME}
  src/main.cpp
)

target_link_libraries(${PROJECT_NAME}
  PRIVATE arithmetic
)

enable_lto(${PROJECT_NAME})
enable_sanitizers(${PROJECT_NAME})
enable_strict_warnings(${PROJECT_NAME})

# === Unit Testing ===
if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()
