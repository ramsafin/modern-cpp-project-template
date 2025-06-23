#include <gtest/gtest.h>

TEST(SanityCheck, BasicAssertion)
{
  EXPECT_EQ(1 + 1, 2);
}

TEST(SanityCheck, StringsWork)
{
  std::string hello = "Hello";
  EXPECT_EQ(hello + " World", "Hello World");
}
