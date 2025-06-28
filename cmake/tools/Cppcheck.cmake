find_program(CPPCHECK_EXE NAMES cppcheck)

if(CPPCHECK_EXE)
  file(GLOB_RECURSE CPPCHECK_SOURCE_FILES
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_SOURCE_DIR}/src/**/*.cpp"
    "${CMAKE_SOURCE_DIR}/include/**/*.hpp"
  )

  add_custom_target(cppcheck
    COMMAND ${CPPCHECK_EXE}
      --enable=all
      --inconclusive
      --quiet
      ${CPPCHECK_SOURCE_FILES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Running cppcheck analysis"
    VERBATIM
  )
else()
  message(STATUS "⚠️ cppcheck not found — 'cppcheck' target will not be available.")
endif()
