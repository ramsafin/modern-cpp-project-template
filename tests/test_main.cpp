#include <gtest/gtest.h>

#if defined(__has_feature)
#if __has_feature(address_sanitizer)
#include <sanitizer/lsan_interface.h>
#endif
#endif

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
#if defined(__has_feature)
#if __has_feature(address_sanitizer)
  __lsan_disable();  // disable leak detection
#endif
#endif
  return RUN_ALL_TESTS();
}
