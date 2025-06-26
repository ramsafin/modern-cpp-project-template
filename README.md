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
- ✅ Pre-commit hooks + clang-format + clang-tidy
- ✅ GitHub Actions CI for builds, tests, and formatting

---

## 🚀 Build & Test

This project uses [CMake Presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html).

### Build locally

```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
ctest --preset gcc-RelWithDebInfo
```

### Run Unit Tests

Unit tests are enabled by default via the `ENABLE_TESTING` option.
Tests work with all build types, but `Sanitize` is recommended to catch runtime issues (e.g., buffer overflows).

Run tests using the `Sanitize` build type (recommended):
```bash
ctest --preset clang-Sanitize
```

Tests are auto-discovered via GoogleTest and integrated into CTest.

### Code Style and Lint

This project uses:
- `.clang-format` for formatting
- `.clang-tidy` for linting
- Pre-commit hook to enforce formatting

To check formatting locally:
```bash
clang-format -i src/*.cpp include/*.hpp tests/*.cpp tests/*.hpp
```

### Tips

- All sanitizers are enabled via the `Sanitize` build type.
- CI runs on Clang + GCC using GitHub Actions.
- You can safely override default settings in `CMakePresets.json`.

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

## Contributing

Pull requests are welcome. Please ensure code is formatted and tests pass before submitting.
