include_guard(GLOBAL)

if(ENABLE_CPPCHECK)
  find_program(CPPCHECK_EXE NAMES cppcheck)

  if(CPPCHECK_EXE)
    file(GLOB_RECURSE CPPCHECK_SOURCE_FILES
      CONFIGURE_DEPENDS
      "${CMAKE_SOURCE_DIR}/src/*.cpp"
      "${CMAKE_SOURCE_DIR}/src/**/*.cpp"
      "${CMAKE_SOURCE_DIR}/include/**/*.hpp"
    )

    # Filter only project-local files
    list(FILTER CPPCHECK_SOURCE_FILES INCLUDE REGEX "^${CMAKE_SOURCE_DIR}/(src|include)/.*")

    add_custom_target(cppcheck
      COMMAND ${CPPCHECK_EXE}
        --enable=all
        --inconclusive
        --quiet
        --project=${CMAKE_BINARY_DIR}/compile_commands.json
        --suppress=missingIncludeSystem
        --exclude=tests
        --exclude=benchmarks
        --exclude=_deps
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Running cppcheck static analysis"
      VERBATIM
    )

    message(STATUS "Cppcheck target 'cppcheck' is available.")
  else()
    message(STATUS "Cppcheck not found — 'cppcheck' target will not be available.")
  endif()
endif()
