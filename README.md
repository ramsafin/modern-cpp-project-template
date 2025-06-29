# Modern C++ Project Template

> ⚡A clean starter for modern C++20+ projects with CMake, tests, benchmarks, CI, coverage, and developer tooling.

[![CI](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml)
[![Clang-Format](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml)
[![Clang-Tidy](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Project Structure](#project-structure)
  - [Prerequisites](#prerequisites)
  - [Build Presets](#build-presets)
  - [Building the Project](#building-the-project)
  - [Sanitizers](#sanitizers)
- [Developer Tooling](#developer-tooling)
  - [Code Formatting](#code-formatting)
  - [Static Analysis](#static-analysis)
  - [API Documentation](#api-documentation)
- [Installation](#installation)
  - [Install the Library](#install-the-library)
  - [Use in External Project](#use-in-external-project)
- [Testing and Coverage](#testing-and-coverage)
  - [Unit Testing](#unit-testing)
  - [Benchmarks](#benchmarks)
  - [Code Coverage](#code-coverage)
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

> The project gracefully skips unavailable tools and emits a warning if optional tools aren't found.

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

To configure and build using a preset:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
```

### Sanitizers

The `Sanitize` build type enables runtime checks for memory errors (AddressSanitizer, UndefinedBehaviorSanitizer).

```bash
cmake --preset gcc-Sanitize
cmake --build --preset gcc-Sanitize
ctest --preset gcc-Sanitize
```

## Developer Tooling

This project includes several tools to ensure code quality and maintainability. All tools are integrated as CMake targets and run independently from the build system.

### Code Formatting

Format all C++ files using `.clang-format`. 

Run the check:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo --target clang-format-check
```
> Use a pre-commit hook to automatically check formatting before each commit.

### Static Analysis

- Lint source code using [Clang-Tidy](https://clang.llvm.org/extra/clang-tidy).
- Run deep static analysis using [Cppcheck](https://cppcheck.sourceforge.io/).

Run `clang-tidy` analysis:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo --target clang-tidy
```
> Configurable via `.clang-tidy`, with selective checks enabled.

Run `cppcheck` analysis:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo --target cppcheck
```
> Targets only your project files — third-party code is excluded.

### API Documentation

If `BUILD_DOCS=ON`, a `docs` target becomes available to generate HTML API documentation:
```bash
cmake --preset gcc-RelWithDebInfo -DBUILD_DOCS=ON
cmake --build --preset gcc-RelWithDebInfo --target docs
```

> Output will be generated in `build/<preset>/docs/html/`

## Installation

This project supports CMake's standard installation flow and can be consumed by other CMake-based projects using `find_package()`.

### Install the Library

To install the library (headers, compiled `.a`/`.so`, CMake config files):
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
cmake --install build/gcc-RelWithDebInfo --prefix install  # or /usr/local
```
- This installs the library to the `install/` directory.
- You can also install system-wide with `--prefix /usr/local` (requires `sudo`).

### Use in External Project

After installation, consume the library like this in another CMake project:
```bash
find_package(modern_cpp_project REQUIRED)
target_link_libraries(my_app PRIVATE modern_cpp_project::math)
```

Make sure CMake knows where to find the installed package:
```bash
cmake -DCMAKE_PREFIX_PATH=/path/to/install ..
```

> The install includes CMake config files, version info, and targets for linking.

## Testing and Coverage

This project includes unit tests, benchmarks, and support for code coverage analysis.

### Unit Testing

Unit tests use **GoogleTest** (via `FetchContent`) and are auto-discovered.
- Tests are enabled by default (`ENABLE_TESTING=ON`)
- Run with any build type (e.g., `Debug`, `RelWithDebInfo`, `Sanitize`)

Build and run tests:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
ctest --preset gcc-RelWithDebInfo
```

> Use `Sanitize` builds to detect memory and undefined behavior.

### Benchmarks

Benchmarks are written using **Google Benchmark** and are **not enabled** by default (`ENABLE_BENCHMARKS=OFF`).

> Benchmarks are skipped in `Sanitize` and `Coverage` builds for performance and accuracy.

Build and run:
```bash
cmake --preset gcc-Release -DENABLE_BENCHMARKS=ON
cmake --build --preset gcc-Release --target benchmarks
./build/gcc-Release/benchmarks/benchmarks
```

### Code Coverage

Coverage is powered by `lcov` + `genhtml`, enabled via the special `Coverage` build type.

Generate coverage report:
```bash
cmake --preset gcc-Coverage
cmake --build --preset gcc-Coverage
ctest --preset gcc-Coverage
cmake --build --preset gcc-Coverage --target coverage
```

> Coverage report can be found in `build/gcc-Coverage/coverage-report/index.html`
> Coverage excludes third-party and application/benchmark targets. Only `src/` and `tests/` are measured.

## Contributing

Pull requests are welcome. Please ensure:
- Code passes all tests
- Code is formatted and clang-tidy clean
- Commits follow clear, atomic changes

## License

This project is licensed under the **Apache License 2.0**.

You are free to use, modify, distribute, and include this code in commercial or open-source projects.
