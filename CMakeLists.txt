cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
project(modern_cpp_project LANGUAGES CXX VERSION 0.1.0)

# === C++ Standard ===
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# === Compile Commands ===
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# === Custom Build Types ===
if(CMAKE_CONFIGURATION_TYPES)
  foreach(build_type IN ITEMS Sanitize Coverage)
    list(APPEND CMAKE_CONFIGURATION_TYPES ${build_type})
  endforeach()
  list(REMOVE_DUPLICATES CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING "" FORCE)
endif()

# === Project Options ===
option(ENABLE_WARNINGS          "Enable compiler warnings"          ON)
option(ENABLE_STRICT_WARNINGS   "Treat warnings as errors"          ON)

option(ENABLE_SANITIZERS        "Enable sanitizer instrumentation"  OFF)

option(ENABLE_TESTING           "Build unit tests"                  ON)
option(ENABLE_BENCHMARKS        "Build benchmarks"                  ON)
option(ENABLE_COVERAGE          "Enable coverage instrumentation"   OFF)

option(BUILD_APP                "Build the demo app"                ON)
option(BUILD_DOCS               "Build Doxygen documentation"       ON)

option(ENABLE_CPPCHECK          "Enable cppcheck analysis target"   ON)
option(ENABLE_CLANG_TIDY        "Enable clang-tidy analysis target" ON)
option(ENABLE_CLANG_FORMAT      "Enable clang-format target"        ON)

# === Normalize Build Type (e.g., for string comparison) ===
if(CMAKE_BUILD_TYPE)
  string(TOLOWER "${CMAKE_BUILD_TYPE}" BUILD_TYPE_LOWER)
else()
  set(BUILD_TYPE_LOWER "release")
endif()

# === Auto-toggle Options for Special Build Types ===
if(BUILD_TYPE_LOWER STREQUAL "sanitize")
  set(ENABLE_SANITIZERS ON CACHE BOOL "Enable sanitizers" FORCE)
endif()

if(BUILD_TYPE_LOWER STREQUAL "coverage")
  set(ENABLE_COVERAGE ON CACHE BOOL "Enable coverage" FORCE)
  set(BUILD_APP OFF CACHE BOOL "Disable building app in coverage builds" FORCE)
  set(ENABLE_BENCHMARKS OFF CACHE BOOL "Disable benchmarks in coverage builds" FORCE)
endif()

# === CMake Module Path ===
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# === Core Configuration ===
include(options/Warnings)
include(options/Sanitizers)

# === Optional Tooling ===
include(tools/Coverage)
include(tools/Cppcheck)
include(tools/ClangTidy)
include(tools/ClangFormat)

# === Core library ===
add_subdirectory(src)  # modern_cpp_project::math

# === Application ===
if(BUILD_APP)
  add_subdirectory(app)  # modern_cpp_project_app
endif()

# === Unit Tests ===
if(ENABLE_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()

# === Benchmarks ===
if(ENABLE_BENCHMARKS)
  add_subdirectory(benchmarks)
endif()

# === Documentation ===
include(tools/Doxygen)

# === Installation ===
include(install/InstallConfig)
