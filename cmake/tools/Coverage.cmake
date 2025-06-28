include_guard(GLOBAL)

function(enable_coverage target)
  if(ENABLE_COVERAGE)
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
      target_compile_options(${target} PRIVATE --coverage -O0 -g)
      target_link_options(${target} PRIVATE --coverage)
      message(STATUS "Coverage instrumentation enabled for target '${target}'")
    else()
      message(WARNING "Coverage instrumentation not supported for ${CMAKE_CXX_COMPILER_ID}")
    endif()
  else()
    message(STATUS "Skipping coverage flags for '${target}' (ENABLE_COVERAGE=OFF)")
  endif()
endfunction()

if(ENABLE_COVERAGE)
  find_program(LCOV_EXECUTABLE NAMES lcov)
  find_program(GENHTML_EXECUTABLE NAMES genhtml)

  if(LCOV_EXECUTABLE AND GENHTML_EXECUTABLE)
    set(COVERAGE_INFO "${CMAKE_BINARY_DIR}/coverage.info")
    set(COVERAGE_CLEANED "${CMAKE_BINARY_DIR}/coverage.info.cleaned")
    set(COVERAGE_REPORT_DIR "${CMAKE_BINARY_DIR}/coverage-report")

    add_custom_target(coverage
      COMMAND ${LCOV_EXECUTABLE}
        --directory .
        --capture
        --output-file "${COVERAGE_INFO}"
        --ignore-errors mismatch
      COMMAND ${LCOV_EXECUTABLE}
        --remove "${COVERAGE_INFO}"
        /usr/* ${CMAKE_BINARY_DIR}/*
        --output-file "${COVERAGE_CLEANED}"
      COMMAND ${GENHTML_EXECUTABLE}
        "${COVERAGE_CLEANED}"
        --output-directory "${COVERAGE_REPORT_DIR}"
      WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
      COMMENT "Generating coverage report with lcov + genhtml"
      VERBATIM
    )

    message(STATUS "Coverage support available: use `cmake --build --target coverage`")
  elseif(LCOV_EXECUTABLE)
    message(WARNING "lcov found but genhtml is missing — HTML report won't be generated.")
  elseif(GENHTML_EXECUTABLE)
    message(WARNING "genhtml found but lcov is missing — coverage data cannot be captured.")
  else()
    message(STATUS "Coverage tools not found — reporting disabled.")
  endif()
endif()
