include(FetchContent)

set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "Disable benchmark library tests")

FetchContent_Declare(
  benchmark
  URL https://github.com/google/benchmark/archive/refs/tags/v1.9.4.zip
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE  # Prevents timestamp-related rebuild issues
)

FetchContent_MakeAvailable(benchmark)

add_executable(benchmarks
  bench_arithmetic.cpp
)

target_link_libraries(benchmarks
  PRIVATE benchmark::benchmark benchmark::benchmark_main ${PROJECT_NAME}::math
)

enable_strict_warnings(benchmarks)
