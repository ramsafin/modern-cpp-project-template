/**
 * @mainpage Modern C++ Project Template
 *
 * A modern C++20+ starter project using CMake, GoogleTest, sanitizers, GitHub Actions, and developer tooling.
 *
 * ## ✅ Features
 *
 * - CMake presets with Clang & GCC support
 * - C++20 (extendable to C++23)
 * - GoogleTest (with FetchContent)
 * - Sanitizers: AddressSanitizer + UndefinedBehaviorSanitizer
 * - Link Time Optimization (LTO) presets
 * - clang-format + clang-tidy + pre-commit hook
 * - GitHub Actions CI for builds, tests, and formatting
 * - Install targets
 *
 * ## 🚀 Getting Started
 *
 * This project uses [CMake Presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html).
 *
 * ### Build and Test
 * ```bash
 * cmake --preset gcc-RelWithDebInfo
 * cmake --build --preset gcc-RelWithDebInfo
 * ctest --preset gcc-RelWithDebInfo
 * ```
 *
 * To list available presets:
 * ```bash
 * cmake --list-presets
 * ```
 *
 * ### Sanitizers
 *
 * Use the `Sanitize` build type to catch runtime issues:
 * ```bash
 * cmake --preset gcc-Sanitize
 * cmake --build --preset gcc-Sanitize
 * ctest --preset gcc-Sanitize
 * ```
 *
 * ### LTO Builds
 * ```bash
 * cmake --preset gcc-RelWithDebInfo-lto
 * cmake --build --preset gcc-RelWithDebInfo-lto
 * ```
 *
 * ### Testing
 *
 * - Enabled via `ENABLE_TESTING` (default: ON)
 * - Works with all build types
 * - `Sanitize` is recommended for catching runtime errors
 * - GoogleTest + CTest integration
 *
 * ### Code Style and Linting
 *
 * - Uses `.clang-format` (enforced via pre-commit)
 * - Uses `.clang-tidy` for static analysis
 *
 * Manual usage:
 * ```bash
 * clang-format -i src/*.cpp include/**/*.hpp tests/*.cpp
 * clang-tidy src/*.cpp -p build/gcc-RelWithDebInfo
 * ```
 *
 * ## 📦 Installation
 *
 * To install includes, libraries, and CMake config files:
 * ```bash
 * cmake --preset gcc-RelWithDebInfo
 * cmake --build --preset gcc-RelWithDebInfo
 * cmake --install build/gcc-RelWithDebInfo --prefix install
 * ```
 *
 * ## 🔗 Using in Another Project
 *
 * After installation:
 * ```cmake
 * find_package(modern_cpp_project REQUIRED)
 * target_link_libraries(<your_app> PRIVATE modern_cpp_project::math)
 * ```
 *
 * Set this variable in your project:
 * ```bash
 * cmake -DCMAKE_PREFIX_PATH=/path/to/install ..
 * ```
 *
 * ## 📄 License
 *
 * Licensed under the [Apache License 2.0](https://github.com/ramsafin/modern-cpp-project-template/blob/master/LICENSE)
 *
 * ## 🤝 Contributing
 *
 * - Code must pass all tests
 * - Code must be clang-format and clang-tidy clean
 * - Commits should follow clear, atomic changes
 */
