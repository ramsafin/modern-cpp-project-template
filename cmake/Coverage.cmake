if(ENABLE_COVERAGE)
  find_program(GCOVR_EXE gcovr REQUIRED)
  set(COVERAGE_OUTPUT_DIR "${CMAKE_BINARY_DIR}/coverage-report")

  add_custom_target(coverage
    COMMAND ${CMAKE_COMMAND} -E make_directory ${COVERAGE_OUTPUT_DIR}
    COMMAND ${GCOVR_EXE}
            --root ${CMAKE_SOURCE_DIR}
            --print-summary
            --html
            --html-details
            --fail-under-line 80
            --exclude ${CMAKE_BINARY_DIR}
            --exclude ${CMAKE_SOURCE_DIR}/app
            --exclude ${CMAKE_SOURCE_DIR}/tests
            --exclude ${CMAKE_SOURCE_DIR}/benchmarks
            --output ${COVERAGE_OUTPUT_DIR}/index.html
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating coverage report with gcovr"
    VERBATIM
  )
endif()
