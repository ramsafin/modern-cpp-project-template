include_guard(GLOBAL)

if(ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_EXE NAMES clang-tidy)

  if(CLANG_TIDY_EXE)
    file(GLOB_RECURSE TIDY_SOURCE_FILES
      CONFIGURE_DEPENDS
      "${CMAKE_SOURCE_DIR}/src/*.cpp"
      "${CMAKE_SOURCE_DIR}/include/**/*.hpp"
    )

    # Filter only project sources (avoid _deps, build, etc.)
    list(FILTER TIDY_SOURCE_FILES INCLUDE REGEX "^${CMAKE_SOURCE_DIR}/(src|include)/.*")

    add_custom_target(clang-tidy
      COMMAND ${CLANG_TIDY_EXE}
        ${TIDY_SOURCE_FILES}
        --quiet
        -p ${CMAKE_BINARY_DIR}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Running clang-tidy analysis"
      VERBATIM
    )

    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/.clang-tidy")
      message(WARNING "No .clang-tidy file found in project root.")
    endif()

    message(STATUS "clang-tidy target 'clang-tidy' is available.")
  else()
    message(STATUS "clang-tidy not found — 'clang-tidy' target will not be available.")
  endif()
endif()
