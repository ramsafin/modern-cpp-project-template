cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
project(modern_cpp_project LANGUAGES CXX VERSION 0.1.0)

# Enable C++20 with strict enforcement
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Export compile_commands.json for clangd and clang-tidy
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Options
option(ENABLE_TESTING    "Build tests" ON)
option(ENABLE_BENCHMARKS "Build benchmarks" ON)
option(BUILD_APP         "Build the demo application" ON)
option(BUILD_DOCS        "Build documentation via Doxygen" ON)

# Add custom "Sanitize" build type
if(CMAKE_CONFIGURATION_TYPES)
  list(APPEND CMAKE_CONFIGURATION_TYPES Sanitize)
  list(REMOVE_DUPLICATES CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING "" FORCE)
endif()

# Load cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Warnings, sanitizers, Link Time Optimization (LTO)
include(options/LTO)
include(options/Warnings)
include(options/Sanitizers)

# === Libraries ===
add_subdirectory(src) # modern_cpp_project::math

# === Application ===
if(BUILD_APP)
  add_subdirectory(app) # modern_cpp_project_app
endif()

# === Tests ===
if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()

if(ENABLE_BENCHMARKS)
  add_subdirectory(benchmarks)
endif()

# === Docs ===
if(BUILD_DOCS)
  include(tools/Doxygen)
endif()

# === Installation ===
include(install/InstallConfig)

# === Formatting ===
include(tools/ClangFormat)

# === Linting ===
include(tools/ClangTidy)
