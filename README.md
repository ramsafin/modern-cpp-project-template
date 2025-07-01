# Modern C++ Project Template

> ⚡A clean starter for modern C++20 projects with CMake Presets, testing, benchmarking, sanitizers, coverage, and developer tooling.

[![CI](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml)
[![Clang-Format](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml)
[![Clang-Tidy](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Build Presets](#build-presets)
- [Workflow Presets](#workflow-presets)
- [Building and Testing](#building-and-testing)
- [Sanitizers](#sanitizers)
- [Benchmarking](#benchmarking)
- [Coverage](#coverage)
- [Developer Tooling](#developer-tooling)
  - [Code Formatting](#code-formatting)
  - [Static Analysis](#static-analysis)
- [Installation](#installation)
- [Package](#packaging)
- [Contributing](#contributing)
- [License](#license)


## Features

- **Modern C++20+**: fully enabled C++20 with support for upgrading to C++23
- **CMake Presets**: reproducible, platform‑agnostic builds via `CMakePresets.json`
- **Testing**: integrated with GoogleTest using `gtest_discover_tests()`
- **Benchmarking**: optional benchmarks with Google Benchmark
- **Sanitizers**: ASan and UBSan runtime checks
- **Coverage**: `gcovr`-powered HTML reports
- **Developer Tooling**:
  - `clang-format`, `clang-tidy`, `cppcheck` custom targets
  - Configurable via pre-commit and CI hooks
- **Installation**: provides `find_package(...)` integration with proper exports
- **CI-Ready**: GitHub Actions for builds, linting, testing, and formatting


## Project Structure

```text
modern-cpp-project-template/
├── app/                 # Optional demo application
├── benchmarks/          # Google Benchmark performance tests
├── cmake/               # Custom CMake modules (warnings, sanitizers, tooling)
├── include/             # Public headers
├── src/                 # Library source files
├── tests/               # Unit tests using GoogleTest
├── .clang-format        # Formatting rules
├── .clang-tidy          # Static analysis configuration
├── CMakeLists.txt       # Top-level CMake build configuration
├── CMakePresets.json    # Build, test, and workflow presets
└── README.md
```

## Prerequisites

Before building the project, make sure the following tools are installed on your system:
- **CMake ≥ 3.23** (tested with 3.28+)
- **C++ Compiler**: GCC ≥ 10 or Clang ≥ 12
- **Ninja** (optional; recommended), or your generator of choice
- **gcovr** (for code coverage reports)
- **clang-format**, **clang-tidy**, **cppcheck** (optional diagnostics)

> Tools not found are skipped with a warning; features gated by CMake option.

## Build Presets

This project uses [**CMake Presets**](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html) to simplify configuration.

| **Preset**          | **Notes**                                              |
| :------------------ |:------------------------------------------------------ |
| `Debug`             | Debugging with no optimizations                        |
| `Release`           | Optimized builds without debug symbols                 |
| `RelWithDebInfo`    | Optimized build with debug symbols (**recommended**)   |
| `Sanitize`          | Builds with runtime checks enabled (ASan/UBSan)        |
| `Coverage`          | Builds instrumented for coverage reporting             |
| `Release-Bench`     | Builds Release + benchmarks                            |

List available presets:
```bash
cmake --list-presets
```

## Workflow Presets

| **Preset**          | **Notes**                                           |
| :------------------ |:--------------------------------------------------- |
| `check-sanitize`    | `Sanitize` → build → run tests                      |
| `coverage-report`   | `Coverage` → build → run tests → *(generate report) |
| `dist`              | `RelWithDebInfo` → build → package via `CPack`      |

List available workflow presets:
```bash
cmake --workflow --list-presets
```

Run workflows with:
```bash
cmake --workflow --preset check-sanitize
```

## Building and Testing

Configure and build:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
```

Run unit tests:
```bash
ctest --preset gcc-RelWithDebInfo
```

## Sanitizers

```bash
cmake --preset gcc-Sanitize
cmake --build --preset gcc-Sanitize
ctest --preset gcc-Sanitize
```

or run the workflow:

```bash
cmake --workflow --preset check-sanitize
```

## Benchmarking

```bash
cmake --preset gcc-Release-Bench
cmake --build --preset gcc-Release-Bench --target benchmarks
./build/gcc-Release-Bench/benchmarks/benchmarks
```

## Coverage

```bash
cmake --preset gcc-Coverage
cmake --build --preset gcc-Coverage
ctest --preset gcc-Coverage
cmake --build --preset gcc-Coverage --target coverage
```

or run the workflow:
```bash
cmake --workflow --preset coverage-report
cmake --build --preset gcc-Coverage --target coverage
```

> Find the report in `build/gcc-Coverage/coverage-report/index.html`

## Developer Tooling

### Code Formatting

Format all C++ files using `.clang-format`.

Check formatting:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo --target format-check
```

Reformat everything:
```bash
cmake --build --preset gcc-RelWithDebInfo --target format
```

> Use a pre-commit hook to automatically check formatting before each commit.

### Static Analysis

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

## Installation

```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
cmake --install build/gcc-RelWithDebInfo --prefix install  # or /usr/local
```

- This installs the library to the `install/` directory.
- You can also install system-wide with `--prefix /usr/local` (requires `sudo`).


After installation, consume the library like this in another CMake project:
```bash
find_package(modern_cpp REQUIRED)
add_executable(my_app ...)
target_link_libraries(my_app PRIVATE modern_cpp::library)
```

Make sure CMake knows where to find the installed package:
```bash
cmake -DCMAKE_PREFIX_PATH=/path/to/install ..
```

## Packaging

Once you’ve built your release­‐type binaries (e.g. `RelWithDebInfo`), you can produce `.tar.gz` and `.zip` archives via CPack:

Use package presets:
```bash
cmake --preset gcc-Release
cmake --build --preset gcc-Release
cpack --preset package-gcc-Release
```

or workflow preset:
```bash
cmake --workflow --preset gcc-Release-dist
```

> This generates `.tar.gz` and `.zip` archives in `build/gcc-Release`.

## Contributing

Pull requests are welcome. Please ensure:
- Code passes all tests
- Code is formatted and clang-tidy clean
- Commits follow clear, atomic changes

## License

This project is licensed under the **Apache License 2.0**.

You are free to use, modify, distribute, and include this code in commercial or open-source projects.
