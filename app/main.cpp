#include <iostream>

#include "modern_cpp/library.hpp"

int main() {
  const int LEFT  = 10;
  const int RIGHT = 4;

  std::cout << "Add: " << modern_cpp::add(LEFT, RIGHT) << '\n';
  std::cout << "Subtract: " << modern_cpp::subtract(LEFT, RIGHT) << '\n';

  return 0;
}
