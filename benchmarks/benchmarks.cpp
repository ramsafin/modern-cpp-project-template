#include <benchmark/benchmark.h>

#include "modern_cpp/library.hpp"

static void bmAdd(benchmark::State &state) {
  for (auto _ : state) {  // NOLINT
    benchmark::DoNotOptimize(modern_cpp::add(1, 2));  // NOLINT (readability-magic-numbers)
  }
}

static void bmSubtract(benchmark::State &state) {
  for (auto _ : state) {  // NOLINT
    benchmark::DoNotOptimize(modern_cpp::subtract(5, 3));  // NOLINT (readability-magic-numbers)
  }
}

BENCHMARK(bmAdd);  // NOLINT(cppcoreguidelines-avoid-non-const-global-variables)
BENCHMARK(bmSubtract);  // NOLINT (cppcoreguidelines-avoid-non-const-global-variables)
