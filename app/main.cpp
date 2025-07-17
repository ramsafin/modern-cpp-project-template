#include <spdlog/sinks/basic_file_sink.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include <spdlog/spdlog.h>

#include "modern_cpp/library.hpp"

int main() {
  auto console = spdlog::stdout_color_mt("console");
  spdlog::set_level(spdlog::level::debug);

  const int left = 10;
  const int right = 4;

  console->info("Calling add({}, {})", left, right);
  const int sum = modern_cpp::add(left, right);
  console->info("Result of add: {}", sum);

  console->info("Calling subtract({}, {})", left, right);
  const int diff = modern_cpp::subtract(left, right);
  console->info("Result of subtract: {}", diff);

  return 0;
}
