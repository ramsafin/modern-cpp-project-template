# Modern C++ Project Template

> ⚡A clean starter for modern C++20+ projects with CMake, tests, benchmarks, CI, coverage, and developer tooling.

[![CI](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml)
[![Clang-Format](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml)
[![Clang-Tidy](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Build and Test](#build-and-test)
  - [Sanitizers](#sanitizers)
  - [Coverage](#coverage)
  - [Installation](#installation)
- [Tooling](#tooling)
  - [Code Formatting](#code-formatting)
  - [Static Analysis](#static-analysis)
  - [Pre-Commit Hooks](#pre-commit-hooks)
- [Documentation](#documentation)
- [Usage in Other Projects](#usage-in-other-projects)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Modern C++20+**: Fully enabled C++20 with support for upgrading to C++23
- **CMake Presets**: Unified and reproducible builds via `CMakePresets.json`
- **Testing**: Integrated with GoogleTest using `gtest_discover_tests()`
- **Benchmarking**: Optional benchmarks with Google Benchmark
- **Sanitizers & Coverage**:
  - Address/UB sanitizers for runtime checks
  - `lcov` + `genhtml` support for coverage analysis
- **Developer Tooling**:
  - `clang-format`, `clang-tidy`, `cppcheck`
  - Configurable via pre-commit hook and CI
- **Doxygen Docs**: Auto-generated API docs with optional target
- **Installable Library**: Provides `find_package(...)` integration
- **CI-Ready**: GitHub Actions for builds, linting, testing, and formatting

## Getting Started

### Project Structure

```text
modern-cpp-project-template/
├── app/                 # (Optional) Main demo application
├── benchmarks/          # Google Benchmark performance tests
├── cmake/               # Custom CMake modules (warnings, sanitizers, etc.)
│   ├── install/         # Install configuration templates
├── docs/                # Doxygen configuration and outputs
├── include/             # Public headers (installed)
├── src/                 # Core library source files
├── tests/               # Unit tests using GoogleTest
├── .clang-format        # Code formatting rules
├── .clang-tidy          # Static analysis configuration
├── .gitignore
├── CMakeLists.txt       # Top-level CMake build configuration
├── CMakePresets.json    # Recommended build configurations
└── README.md
```

### Prerequisites

Before building the project, make sure the following tools are installed on your system:
| Tool                               | Required   | Notes                                                    |
| :--------------------------------- | :--------  |:-------------------------------------------------------- |
| CMake                              | _Yes_      | Version ≥ 3.23 (required for presets)                    |
| C++ Compiler                       | _Yes_      | GCC (≥ 10) or Clang (≥ 12) recommended                   |
| Ninja                              | _Optional_ | Used as the default build system (set via CMake presets) |
| Doxygen                            | _Optional_ | For generating documentation (only if `BUILD_DOCS=ON`)   |
| lcov / gentml                      | _Optional_ | For code coverage reports (`Coverage` build type)        |
| cppcheck, clang-format, clang-tidy | _Optional_ | For static analysis and formatting checks                |

You can install tools on Ubuntu like so:
```bash
sudo apt update
sudo apt install build-essential cmake ninja-build clang-format clang-tidy cppcheck doxygen lcov
```

**Note:** the project gracefully skips unavailable tools and emits a warning if optional tools aren't found.

### Build Presets

This project uses [**CMake Presets**](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html) to simplify and standardize configuration and build workflows. Each preset is tailored to a specific purpose.

| Build Type          | Purpose                                                |
| :------------------ |:------------------------------------------------------ |
| `Debug`             | Debugging with no optimizations                        |
| `Release`           | Optimized builds without debug symbols                 |
| `RelWithDebInfo`    | Optimized build with debug symbols (recommended)       |
| `Sanitize`          | Builds with runtime checks enabled (ASan, UBSan, etc.) |
| `Coverage`          | Builds instrumented for coverage reporting             |

Run to list all presets:
```bash
cmake --list-presets
```

### Building the Project

> All commands assume you are using CMake Presets, which are fully configured for this project.

#### Configure and Build

To configure and build using a preset:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
```

### Run Tests

All tests are built with [GoogleTest](https://github.com/google/googletest). Enable them with the `ENABLE_TESTING` option (**enabled** by default).

```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
ctest --preset gcc-RelWithDebInfo
```

### Sanitizers

The `Sanitize` build type enables runtime checks for memory errors (AddressSanitizer, UndefinedBehaviorSanitizer).

```bash
cmake --preset gcc-Sanitize
cmake --build --preset gcc-Sanitize
ctest --preset gcc-Sanitize
```

### Generate Code Coverage

Use the `Coverage` preset to instrument code and generate a coverage report (requires `lcov` and `genhtml`):
```bash
cmake --preset gcc-Coverage
cmake --build --preset gcc-Coverage
ctest --preset gcc-Coverage
cmake --build --preset gcc-Coverage --target coverage
```

View the report in:
```bash
build/gcc-Coverage/coverage-report/index.html
```

### Install the Library

```bash
cmake --preset gcc-Release
cmake --build --preset gcc-Release
cmake --install build/gcc-Release --prefix install  # or /usr/local
```

This installs:
- Compiled static/shared libraries
- Public headers from `include/`
- CMake config files for `find_package(...)` consumers

## Contributing

Pull requests are welcome. Please ensure:
- Code passes all tests
- Code is formatted and clang-tidy clean
- Commits follow clear, atomic changes

## License

This project is licensed under the [Apache License 2.0](LICENSE).

You are free to use, modify, distribute, and include this code in commercial or open-source projects.
