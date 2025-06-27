find_package(Doxygen QUIET)

if(DOXYGEN_FOUND)
  set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/docs/Doxyfile.in)
  set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile.generated)
  set(DOXYGEN_OUTPUT_DIR ${CMAKE_BINARY_DIR}/docs/html)

  if(EXISTS ${DOXYGEN_IN})
    # Ensure output directory exists
    file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIR})

    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)

    add_custom_target(docs
      COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
      WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
      COMMENT "Generating API documentation with Doxygen"
      VERBATIM
    )
    set_target_properties(docs PROPERTIES FOLDER "Documentation")
    message(STATUS "ℹ️\t'docs' target is available. Output: ${DOXYGEN_OUTPUT_DIR}")
  else()
    message(WARNING "Doxygen file not found: ${DOXYGEN_IN}")
  endif()
else()
  message(STATUS "⚠️\tDoxygen not found. 'docs' target will not be available.")
endif()
