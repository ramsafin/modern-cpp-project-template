find_program(CLANG_FORMAT_EXE NAMES clang-format)

if(CLANG_FORMAT_EXE)

  # Collect all relevant source/header files recursively
  file(GLOB_RECURSE ALL_SOURCE_FILES
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_SOURCE_DIR}/src/**/*.cpp"
    "${CMAKE_SOURCE_DIR}/include/*.hpp"
    "${CMAKE_SOURCE_DIR}/include/**/*.hpp"
    "${CMAKE_SOURCE_DIR}/tests/*.cpp"
    "${CMAKE_SOURCE_DIR}/tests/**/*.cpp"
    "${CMAKE_SOURCE_DIR}/tests/*.hpp"
    "${CMAKE_SOURCE_DIR}/tests/**/*.hpp"
    "${CMAKE_SOURCE_DIR}/benchmarks/*.cpp"
    "${CMAKE_SOURCE_DIR}/benchmarks/**/*.cpp"
  )

  add_custom_target(clang-format
    COMMAND ${CLANG_FORMAT_EXE} --dry-run --Werror ${ALL_SOURCE_FILES}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "🔍 Checking format (clang-format --dry-run --Werror)"
    VERBATIM
  )
else()
  message(STATUS "⚠️\tclang-format not found — 'clang-format' target will not be available.")
endif()
