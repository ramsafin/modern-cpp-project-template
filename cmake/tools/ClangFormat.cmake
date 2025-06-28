include_guard(GLOBAL)

if(ENABLE_CLANG_FORMAT)

  find_program(CLANG_FORMAT_EXE NAMES clang-format)

  if(CLANG_FORMAT_EXE)
    set(CLANG_FORMAT_DIRS src include tests benchmarks)
    set(CLANG_FORMAT_EXTS *.cpp *.hpp)

    set(ALL_SOURCE_FILES "")
    foreach(dir IN LISTS CLANG_FORMAT_DIRS)
      foreach(ext IN LISTS CLANG_FORMAT_EXTS)
        file(GLOB_RECURSE TMP_FILES "${CMAKE_SOURCE_DIR}/${dir}/**/${ext}")
        list(APPEND ALL_SOURCE_FILES ${TMP_FILES})
      endforeach()
    endforeach()

    add_custom_target(clang-format-check
      COMMAND ${CLANG_FORMAT_EXE} --dry-run --Werror ${ALL_SOURCE_FILES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Checking format (clang-format --dry-run --Werror)"
      VERBATIM
    )

    add_custom_target(clang-format-fix
      COMMAND ${CLANG_FORMAT_EXE} -i ${ALL_SOURCE_FILES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Formatting source files"
      VERBATIM
    )

    if(NOT EXISTS "${CMAKE_SOURCE_DIR}/.clang-format")
      message(WARNING "No .clang-format file found in project root.")
    endif()

    message(STATUS "'clang-format-check' and 'clang-format-fix' targets are available")
  else()
    message(STATUS "clang-format not found — format targets will not be available.")
  endif()

endif()
