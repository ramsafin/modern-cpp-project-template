#–– Options.cmake –– user‐facing toggles

# — Build Targets —
option(ENABLE_TESTING         "Build unit tests"                      ON)
option(ENABLE_BENCHMARKS      "Build benchmarks"                      OFF)
option(BUILD_APP              "Build the demo application"            OFF)

# — Quality Checks —
option(ENABLE_WARNINGS        "Enable compiler warnings"              ON)
option(ENABLE_STRICT_WARNINGS "Treat warnings as errors"              ON)
option(ENABLE_COVERAGE        "Enable coverage instrumentation"       OFF)
option(ENABLE_SANITIZERS      "Enable ASan / UBSan"                   OFF)
option(ENABLE_ASAN            "Enable AddressSanitizer"               OFF)
option(ENABLE_UBSAN           "Enable UndefinedBehaviorSanitizer"     OFF)

# — Static Analysis —
option(ENABLE_CPPCHECK        "Enable Cppcheck integration"           ON)
option(ENABLE_CLANG_TIDY      "Enable clang-tidy integration"         ON)
option(ENABLE_CLANG_FORMAT    "Enable clang-format integration"       ON)

option(ENABLE_CACHE           "Enable ccache to speed up compilation" OFF)

# If someone turns on the “global” sanitizer switch, enable each one
if(ENABLE_SANITIZERS)
  set(ENABLE_ASAN  ON)
  set(ENABLE_UBSAN ON)
endif()


