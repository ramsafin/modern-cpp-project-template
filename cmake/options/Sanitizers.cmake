include_guard(GLOBAL)

# Internal: only apply sanitizers in Sanitize build type
function(enable_sanitizers target)
  if(NOT CMAKE_BUILD_TYPE STREQUAL "Sanitize")
    message(STATUS "Skipping sanitizers for target '${target}' (build type: ${CMAKE_BUILD_TYPE})")
    return()
  endif()

  if(NOT CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    message(WARNING "Sanitizers are only supported with Clang or GCC")
    return()
  endif()

  set(SANITIZER_FLAGS
    -fsanitize=address
    -fsanitize=undefined
    -O1
    -g
  )

  target_compile_options(${target} PRIVATE ${SANITIZER_FLAGS})
  target_link_options(${target} PRIVATE ${SANITIZER_FLAGS})
  message(STATUS "Enabled sanitizers for target '${target}': ${SANITIZER_FLAGS}")
endfunction()
