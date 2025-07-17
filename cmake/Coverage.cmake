if(ENABLE_COVERAGE)
  find_program(GCOVR_EXE gcovr REQUIRED)
  set(COVERAGE_OUTPUT_DIR "${CMAKE_BINARY_DIR}")

  add_custom_target(coverage
    COMMAND ${CMAKE_COMMAND} -E make_directory ${COVERAGE_OUTPUT_DIR}
    COMMAND ${GCOVR_EXE}
            --root ${CMAKE_SOURCE_DIR}
            --xml-pretty
            --print-summary
            --exclude ${CMAKE_BINARY_DIR}
            --exclude ${CMAKE_SOURCE_DIR}/app
            --exclude ${CMAKE_SOURCE_DIR}/tests
            --output ${COVERAGE_OUTPUT_DIR}/coverage.xml
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Generating coverage report with gcovr"
    VERBATIM
  )
endif()
