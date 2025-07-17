#include <benchmark/benchmark.h>

#include "modern_cpp/library.hpp"

static void benchAdd(benchmark::State &state) {
  for (auto _ : state) {  // NOLINT
    benchmark::DoNotOptimize(modern_cpp::add(1, 2));  // NOLINT(*-magic-numbers)
  }
}

static void benchSubtract(benchmark::State &state) {
  for (auto _ : state) {  // NOLINT
    benchmark::DoNotOptimize(modern_cpp::subtract(5, 3));  // NOLINT(*-magic-numbers)
  }
}

BENCHMARK(benchAdd);
BENCHMARK(benchSubtract);
