#include <benchmark/benchmark.h>

#include "math/arithmetic.hpp"

static void BM_Add(benchmark::State& state)
{
  for (auto _ : state)  // NOLINT
  {
    benchmark::DoNotOptimize(math::add(1, 2));  // NOLINT
  }
}

static void BM_Subtract(benchmark::State& state)
{
  for (auto _ : state)  // NOLINT
  {
    benchmark::DoNotOptimize(math::subtract(5, 3));  // NOLINT
  }
}

BENCHMARK(BM_Add);
BENCHMARK(BM_Subtract);
