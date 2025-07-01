#include <gtest/gtest.h>

#include <stdexcept>

#include "modern_cpp/library.hpp"

using namespace modern_cpp;

TEST(AddTests, HandlesAddition) {
  EXPECT_EQ(add(2, 3), 5);
  EXPECT_EQ(add(-1, 1), 0);
}

TEST(SubtactTests, HandlesSubtraction) {
  EXPECT_EQ(subtract(5, 3), 2);
  EXPECT_EQ(subtract(0, 7), -7);
}

TEST(MultiplyTests, HandlesMultiplication) {
  EXPECT_EQ(multiply(4, 6), 24);
  EXPECT_EQ(multiply(-2, 3), -6);
}

TEST(DivideTests, ThrowsOnZero) {
  EXPECT_THROW(divide(5, 0), std::invalid_argument);
}

TEST(DivideTests, NormalDivision) {
  EXPECT_EQ(divide(10, 2), 5);
  EXPECT_EQ(divide(-9, 3), -3);
}
