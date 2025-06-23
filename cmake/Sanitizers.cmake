# Optional CMake variables:
# - ENABLE_ASAN=ON
# - ENABLE_UBSAN=ON

# Create sanitizer interface library if enabled
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(SANITIZER_FLAGS "")

  if(ENABLE_ASAN)
    list(APPEND SANITIZER_FLAGS -fsanitize=address)
  endif()

  if(ENABLE_UBSAN)
    list(APPEND SANITIZER_FLAGS -fsanitize=undefined)
  endif()

  if(SANITIZER_FLAGS)
    add_library(sanitizers INTERFACE)
    target_compile_options(sanitizers INTERFACE ${SANITIZER_FLAGS})
    target_link_options(sanitizers INTERFACE ${SANITIZER_FLAGS})
    message(STATUS "Sanitizer interface created with flags: ${SANITIZER_FLAGS}")
  endif()
endif()

