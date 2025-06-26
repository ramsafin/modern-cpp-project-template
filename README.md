# Modern C++ project template!

[![CI](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml)
[![clang-format](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml)
[![clang-tidy](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

> A modern C++20+ starter project using CMake, GoogleTest, sanitizers, GitHub Actions, and developer tooling.

---

## Features

- ✅ CMake presets with Clang & GCC support
- ✅ C++20 (extendable to C++23)
- ✅ GoogleTest (with `FetchContent`)
- ✅ Sanitizers: AddressSanitizer + UndefinedBehaviorSanitizer
- ✅ Link Time Optimization (LTO) presets
- ✅ Clang-format + Clang-tidy + Pre-commit hook
- ✅ GitHub Actions CI for builds, tests, and formatting
- ✅ Install targets

---

## 🚀 Getting Started

This template uses [CMake Presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html).

### Build and Test

```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
ctest --preset gcc-RelWithDebInfo
```

You can choose from the list of available presets:
```bash
cmake --list-presets
```

#### Enable Sanitizers
Use the special `Sanitize` build type:
```bash
cmake --preset gcc-Sanitize
cmake --build --preset gcc-Sanitize
ctest --preset gcc-Sanitize
```

#### LTO Builds
LTO is enabled via special preset:
```bash
cmake --preset gcc-RelWithDebInfo-lto
cmake --build --preset gcc-RelWithDebInfo-lto
```

#### Testing

Unit tests are enabled by default via the `ENABLE_TESTING` option.
Tests work with all build types, but `Sanitize` is recommended to catch runtime issues (e.g., buffer overflows).

Run tests using the `Sanitize` build type (recommended):
```bash
ctest --preset gcc-Sanitize
```

Tests are auto-discovered via GoogleTest and integrated into CTest.

### Code Style and Linting

This project uses:
- `.clang-format` for formatting (pre-commit hook)
- `.clang-tidy` for linting (static analysis)

Run manually:
```bash
clang-format -i src/*.cpp include/**/*.hpp tests/*.cpp
clang-tidy src/*.cpp -p build/gcc-RelWithDebInfo
```

### Installation

This project supports CMake installation:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
cmake --install build/gcc-RelWithDebInfo --prefix install
```

This will install the compiled library, public headers and CMake config files for `find_package(...)` consumers.

#### Using in Another Project

After installation, your project can consume this library like so:
```cmake
find_package(modern_cpp_project REQUIRED)
target_link_libraries(<your_app> PRIVATE modern_cpp_project::math)
```

Add this to your CMake call:
```bash
cmake -DCMAKE_PREFIX_PATH=/path/to/install ..
```

## License

This project is licensed under the [Apache License 2.0](LICENSE).

You are free to use, modify, distribute, and include this code in commercial or open-source projects.

## Contributing

Pull requests are welcome. Please ensure the following before submitting:
- Code passes all tests
- Code is formatted and clang-tidy clean
= Commits follow clear, atomic changes
