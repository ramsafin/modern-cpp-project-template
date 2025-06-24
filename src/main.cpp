#include <iostream>
#include "math/arithmetic.hpp"

int main()
{
  const int a = 10;
  const int b = 4;

  std::cout << "Add: " << math::add(a, b) << '\n';
  std::cout << "Subtract: " << math::subtract(a, b) << '\n';

  return 0;
}
