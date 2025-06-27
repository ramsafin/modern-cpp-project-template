find_program(CLANG_TIDY_EXE NAMES clang-tidy)

if(CLANG_TIDY_EXE)
  file(GLOB_RECURSE TIDY_SOURCE_FILES
    "${CMAKE_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_SOURCE_DIR}/src/**/*.cpp"
    "${CMAKE_SOURCE_DIR}/tests/*.cpp"
    "${CMAKE_SOURCE_DIR}/tests/**/*.cpp"
  )

  add_custom_target(clang-tidy
    COMMAND ${CLANG_TIDY_EXE} ${TIDY_SOURCE_FILES} --quiet -p ${CMAKE_BINARY_DIR}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "🔍 Running clang-tidy analysis"
    VERBATIM
  )
else()
  message(STATUS "⚠️ clang-tidy not found — 'clang-tidy' target will not be available.")
endif()
