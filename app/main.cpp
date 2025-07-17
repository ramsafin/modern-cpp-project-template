#include <iostream>

#include "modern_cpp/library.hpp"

int main() {
  const int left = 10;
  const int right = 4;

  std::cout << "Add: " << modern_cpp::add(left, right) << '\n';
  std::cout << "Subtract: " << modern_cpp::subtract(left, right) << '\n';

  return 0;
}
