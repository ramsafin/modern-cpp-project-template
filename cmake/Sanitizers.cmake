if(CMAKE_BUILD_TYPE STREQUAL "Sanitize")
  set(SANITIZER_FLAGS
    -fsanitize=address
    -fsanitize=undefined
    -O1
    -g
  )
  message(STATUS "✅\tSanitize build enabled with flags: ${SANITIZER_FLAGS}")
endif()

function(enable_sanitizers target)
  if(CMAKE_BUILD_TYPE STREQUAL "Sanitize")
    target_compile_options(${target} PRIVATE ${SANITIZER_FLAGS})
    target_link_options(${target} PRIVATE ${SANITIZER_FLAGS})
    message(STATUS "✅\tEnabled sanitizers for target ${target}")
  endif()
endfunction()
