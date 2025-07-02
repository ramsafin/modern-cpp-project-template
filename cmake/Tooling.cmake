# === Search All Source Files ===
file(GLOB_RECURSE CORE_SOURCES
  CONFIGURE_DEPENDS
  ${CMAKE_SOURCE_DIR}/src/*.cpp
  ${CMAKE_SOURCE_DIR}/src/*.hpp
  ${CMAKE_SOURCE_DIR}/include/*.hpp
)

set(ALL_SOURCE_FILES ${CORE_SOURCES})

if(ENABLE_TESTING)
  file(GLOB_RECURSE TEST_SOURCES
    CONFIGURE_DEPENDS
    ${CMAKE_SOURCE_DIR}/tests/*.cpp
  )
  list(APPEND ALL_SOURCE_FILES ${TEST_SOURCES})
endif()

if(ENABLE_BENCHMARKS)
  file(GLOB_RECURSE BENCH_SOURCES
    CONFIGURE_DEPENDS
    ${CMAKE_SOURCE_DIR}/benchmarks/*.cpp
  )
  list(APPEND ALL_SOURCE_FILES ${BENCH_SOURCES})
endif()

if(BUILD_APP)
  file(GLOB_RECURSE APP_SOURCES
    CONFIGURE_DEPENDS
    ${CMAKE_SOURCE_DIR}/app/*.cpp
  )
  list(APPEND ALL_SOURCE_FILES ${APP_SOURCES})
endif()

# clang-format
if(ENABLE_CLANG_FORMAT)
  find_program(CLANG_FORMAT_EXE clang-format)
  if(CLANG_FORMAT_EXE)
    add_custom_target(
      format
      COMMAND ${CLANG_FORMAT_EXE} -i ${ALL_SOURCE_FILES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Reformat all sources (clang-format)"
      VERBATIM
    )
    add_custom_target(
      format-check
      COMMAND ${CLANG_FORMAT_EXE} --dry-run --Werror ${ALL_SOURCE_FILES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Check source formatting (clang-format)"
      VERBATIM
    )
  endif()
endif()

# cppcheck
if(ENABLE_CPPCHECK)
  find_program(CPPCHECK_EXE cppcheck)
  if(CPPCHECK_EXE)
    add_custom_target(
      cppcheck
      COMMAND ${CPPCHECK_EXE}
        --enable=all
        --inconclusive
        --std=c++20
        --suppress=missingIncludeSystem
        --suppress=constParameterCallback:${CMAKE_SOURCE_DIR}/benchmarks/benchmarks.cpp
        -I${CMAKE_SOURCE_DIR}/include
        ${ALL_SOURCE_FILES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Run cppcheck analysis"
      VERBATIM
    )
  endif()
endif()

# clang-tidy
if(ENABLE_CLANG_TIDY)
  find_program(CLANG_TIDY_EXE clang-tidy)
  if (CLANG_TIDY_EXE)
    add_custom_target(
      clang-tidy
      COMMAND ${CLANG_TIDY_EXE}
              --quiet
              -p=${CMAKE_BINARY_DIR}
              --config-file=${CMAKE_SOURCE_DIR}/.clang-tidy
              ${ALL_SOURCE_FILES}
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
      COMMENT "Run clang-tidy checks on project sources"
      VERBATIM
    )
  endif()
endif()
