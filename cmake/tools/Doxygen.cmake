include_guard(GLOBAL)

if(NOT BUILD_DOCS)
  message(STATUS "BUILD_DOCS is OFF — skipping Doxygen setup.")
  return()
endif()

find_package(Doxygen REQUIRED)

set(DOXYGEN_QUIET YES)
set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${CMAKE_CURRENT_SOURCE_DIR}/docs/mainpage.md")

set(DOXYGEN_IN "${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in")
set(DOXYGEN_OUT "${CMAKE_CURRENT_BINARY_DIR}/Doxyfile.generated")
set(DOXYGEN_OUTPUT_DIR "${CMAKE_BINARY_DIR}/docs/html" CACHE PATH "Doxygen output directory")

if(EXISTS ${DOXYGEN_IN})
  file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIR})

  configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

  add_custom_target(docs
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Generating API documentation with Doxygen"
    VERBATIM
  )
  set_target_properties(docs PROPERTIES FOLDER "Documentation")
  message(STATUS "'docs' target created. Output: ${DOXYGEN_OUTPUT_DIR}")
else()
  message(WARNING "Doxygen input file not found: ${DOXYGEN_IN}")
endif()

