include(FetchContent)

# Google Benchmark
FetchContent_Declare(
  benchmark
  URL https://github.com/google/benchmark/archive/refs/tags/v1.7.1.zip
  DOWNLOAD_EXTRACT_TIMESTAMP true
)

# Disable Google Benchmark’s own tests and its install rules
set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_INSTALL OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(benchmark)

add_executable(benchmarks
  benchmarks.cpp
)

target_link_libraries(benchmarks
  PRIVATE benchmark::benchmark benchmark::benchmark_main
          ${PROJECT_NAME}::library
)

enable_strict_warnings(benchmarks)
enable_sanitizers(benchmarks)
