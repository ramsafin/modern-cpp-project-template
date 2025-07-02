#–– Options.cmake –– user‐facing toggles
option(ENABLE_WARNINGS        "Enable compiler warnings"          ON)
option(ENABLE_STRICT_WARNINGS "Treat warnings as errors"          ON)
option(ENABLE_TESTING         "Build unit tests"                  ON)
option(ENABLE_BENCHMARKS      "Build benchmarks"                  OFF)
option(ENABLE_COVERAGE        "Enable coverage instrumentation"   OFF)
option(BUILD_APP              "Build the demo application"        OFF)
option(ENABLE_SANITIZERS      "Enable ASan / UBSan"               OFF)
option(ENABLE_ASAN            "Enable AddressSanitizer"           OFF)
option(ENABLE_UBSAN           "Enable UndefinedBehaviorSanitizer" OFF)
option(ENABLE_CPPCHECK        "Enable Cppcheck integration"       ON)
option(ENABLE_CLANG_TIDY      "Enable clang-tidy integration"     ON)
option(ENABLE_CLANG_FORMAT    "Enable clang-format integration"   ON)

# If someone turns on the “global” sanitizer switch, enable each one
if(ENABLE_SANITIZERS)
  set(ENABLE_ASAN  ON CACHE BOOL "" FORCE)
  set(ENABLE_UBSAN ON CACHE BOOL "" FORCE)
endif()
