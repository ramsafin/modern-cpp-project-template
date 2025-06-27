#include <iostream>

#include "math/arithmetic.hpp"

int main()
{
  const int left = 10;
  const int right = 4;

  std::cout << "Add: " << math::add(left, right) << '\n';
  std::cout << "Subtract: " << math::subtract(left, right) << '\n';

  return 0;
}
