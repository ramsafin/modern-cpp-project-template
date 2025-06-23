#include <gtest/gtest.h>
#include <limits>  // numeric_limits

TEST(SanitizerTest, BufferOverflow)
{
  int* arr = new int[2];
  arr[2] = 123;  // ❌ Invalid write
  delete[] arr;
  SUCCEED();
}

TEST(SanitizerTest, IntegerOverflow)
{
  int max = std::numeric_limits<int>::max();
  int result = max + 1;  // ❌ Overflow
  EXPECT_GT(result, 0);
}
