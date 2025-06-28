function(enable_coverage target)
  if(CMAKE_BUILD_TYPE STREQUAL "Coverage")
    target_compile_options(${target} PRIVATE --coverage -O0 -g)
    target_link_options(${target} PRIVATE --coverage)
    message(STATUS "Coverage enabled for target ${target}")
  endif()
endfunction()

find_program(LCOV_EXECUTABLE lcov)
find_program(GENHTML_EXECUTABLE genhtml)

if(LCOV_EXECUTABLE)
  set(COVERAGE_INFO "${CMAKE_BINARY_DIR}/coverage.info")
  set(COVERAGE_CLEANED "${CMAKE_BINARY_DIR}/coverage.info.cleaned")
  set(COVERAGE_REPORT_DIR "${CMAKE_BINARY_DIR}/coverage-report")

  add_custom_target(coverage
    COMMAND ${LCOV_EXECUTABLE} --directory . --capture --output-file ${COVERAGE_INFO} --ignore-errors mismatch
    COMMAND ${LCOV_EXECUTABLE} --remove ${COVERAGE_INFO}
            /usr/* ${CMAKE_BINARY_DIR}/*
            --output-file ${COVERAGE_CLEANED}
    COMMAND ${GENHTML_EXECUTABLE} ${COVERAGE_CLEANED}
            --output-directory ${COVERAGE_REPORT_DIR}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating code coverage report with lcov + genhtml"
    VERBATIM
  )

  message(STATUS "Coverage support enabled (run: cmake --build --target coverage)")
endif()

if(GENHTML_EXECUTABLE)
  add_custom_target(genhtml
    COMMAND ${GENHTML_EXECUTABLE}
      ${CMAKE_BINARY_DIR}/coverage.info.cleaned
      --output-directory ${CMAKE_BINARY_DIR}/coverage-report
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating HTML coverage report with genhtml"
    VERBATIM
  )
else()
  message(STATUS "genhtml not found — 'genhtml' target will not be available.")
endif()
