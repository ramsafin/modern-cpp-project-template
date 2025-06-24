# Enable AddressSanitizer + UndefinedBehaviorSanitizer only for "Sanitize" build type
if(CMAKE_BUILD_TYPE STREQUAL "Sanitize")
  set(SANITIZER_FLAGS
    -fsanitize=address
    -fsanitize=undefined
    -O1
    -g
  )

  add_library(sanitizers INTERFACE)
  target_compile_options(sanitizers INTERFACE ${SANITIZER_FLAGS})
  target_link_options(sanitizers INTERFACE ${SANITIZER_FLAGS})

  message(STATUS "✅ Sanitize build: enabled with flags: ${SANITIZER_FLAGS}")
endif()

function(target_link_with_sanitizers target)
  if(TARGET sanitizers)
    message(STATUS "✅ Enabled sanitizers for target ${target}")
    target_link_libraries(${target} PRIVATE sanitizers)
  endif()
endfunction()
