# Modern C++ Project Template!

[![CI](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/ci.yml)
[![Clang-Format](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-format.yml)
[![Clang-Tidy](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml/badge.svg)](https://github.com/ramsafin/modern-cpp-project-template/actions/workflows/clang-tidy.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

> A modern C++20+ starter project using CMake, GoogleTest, sanitizers, GitHub Actions, and developer tooling.

---

## Features

- ✅ CMake presets with Clang & GCC support
- ✅ C++20 (extendable to C++23)
- ✅ GoogleTest and Google Benchmarks (with `FetchContent`)
- ✅ Sanitizers, Link Time Optimization (LTO)
- ✅ Clang-format + Clang-tidy + Cppcheck + Pre-commit hook
- ✅ GitHub Actions CI for builds, tests, docs, and formatting
- ✅ Install targets (`find_package(...)` supported)
- ✅ Auto-generated API docs via Doxygen

---

## 🚀 Getting Started

This template uses [CMake Presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html).

### Build and Test

```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
ctest --preset gcc-RelWithDebInfo
```

You can list available presets:
```bash
cmake --list-presets
```

#### Enable Sanitizers
Use the special `Sanitize` build type to catch runtime issues:
```bash
cmake --preset gcc-Sanitize
cmake --build --preset gcc-Sanitize
ctest --preset gcc-Sanitize
```

#### Link Time Optimization
LTO is enabled via a dedicated preset:
```bash
cmake --preset gcc-RelWithDebInfo-lto
cmake --build --preset gcc-RelWithDebInfo-lto
```

#### Testing

- Enabled via the `ENABLE_TESTING` option (`ON` by default)
- Works with all build types
- `Sanitize` is recommended to detect memory/undefined behavior issues
- Tests are auto-discovered using `gtest_discover_tests()`

Run tests:
```bash
ctest --preset gcc-Sanitize
```

### Code Style and Linting

This project uses:
- `.clang-format` for formatting (enforced via pre-commit hook)
- `.clang-tidy` for static analysis (linting)

If `clang-format` or `clang-tidy` is not found, the corresponding target will be skipped with a warning.

Run checks manually using custom CMake targets:
```bash
cmake --build --preset gcc-RelWithDebInfo --target clang-format
cmake --build --preset gcc-RelWithDebInfo --target clang-tidy
```

### Installation

Install includes, libs, and CMake config files:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo
cmake --install build/gcc-RelWithDebInfo --prefix install # or /usr/local
```

This will install the compiled library, public headers and CMake config files for `find_package(...)` consumers.

#### Consuming in Another Project

After installation, your project can consume this library like so:
```cmake
find_package(modern_cpp_project REQUIRED)
target_link_libraries(<your_app> PRIVATE modern_cpp_project::math)
```

Add this to your CMake call:
```bash
cmake -DCMAKE_PREFIX_PATH=/path/to/install ..
```

### Documentation

Documentation is generated using [Doxygen](https://www.doxygen.nl). Docs are built from `Doxyfile`, with output in `docs/html/`.

Generate docs locally via custom CMake target:
```bash
cmake --preset gcc-RelWithDebInfo
cmake --build --preset gcc-RelWithDebInfo --target docs
```

View documentation online: [Modern C++ template](https://ramsafin.github.io/modern-cpp-project-template/html).

## License

This project is licensed under the [Apache License 2.0](LICENSE).

You are free to use, modify, distribute, and include this code in commercial or open-source projects.

## Contributing

Pull requests are welcome. Please ensure:
- Code passes all tests
- Code is formatted and clang-tidy clean
- Commits follow clear, atomic changes
