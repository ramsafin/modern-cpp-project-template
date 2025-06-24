#include <gtest/gtest.h>
#include "math/arithmetic.hpp"

TEST(Arithmetic, Add)
{
  EXPECT_EQ(math::add(2, 3), 5);
}

TEST(Arithmetic, Subtract)
{
  EXPECT_EQ(math::subtract(10, 3), 7);
}
