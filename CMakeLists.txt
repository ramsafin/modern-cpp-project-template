cmake_minimum_required(VERSION 3.23 FATAL_ERROR)
project(modern_cpp LANGUAGES CXX VERSION 0.1.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# === Project Configuration ===
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# === Options ===
include(Options)

# === Flags ===
include(CompilerFlags)

# === Search All Source Files ===
file(GLOB_RECURSE CORE_SOURCES
  CONFIGURE_DEPENDS
  src/*.cpp
  src/*.hpp
  include/*.hpp
)

set(ALL_SOURCE_FILES ${CORE_SOURCES})

if(ENABLE_TESTING)
  file(GLOB_RECURSE TEST_SOURCES
    CONFIGURE_DEPENDS
    tests/*.cpp
  )
  list(APPEND ALL_SOURCE_FILES ${TEST_SOURCES})
endif()

if(ENABLE_BENCHMARKS)
  file(GLOB_RECURSE BENCH_SOURCES
    CONFIGURE_DEPENDS
    benchmarks/*.cpp
  )
  list(APPEND ALL_SOURCE_FILES ${BENCH_SOURCES})
endif()

if(BUILD_APP)
  file(GLOB_RECURSE APP_SOURCES
    CONFIGURE_DEPENDS
    app/*.cpp
  )
  list(APPEND ALL_SOURCE_FILES ${APP_SOURCES})
endif()

# === Helpers ===
include(Helpers)

# === Core Library ===
add_subdirectory(src)

# === App ===
if(BUILD_APP)
  add_subdirectory(app)
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

# === Developer Tooling (formatters, linters, etc.) ===
include(Tooling)

# === Coverage ===
include(Coverage)

# === Installation & Export ===
include(install/InstallConfig)

# === Packaging ===
include(CPackConfig)
