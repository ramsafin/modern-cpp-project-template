function(enable_warnings target)
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(${target} PRIVATE
      -Wall
      -Wextra
      -Wpedantic
      -Wconversion
      -Wsign-conversion
    )
    message(STATUS "⚠️\tEnabled warnings for target ${target}")
  endif()
endfunction()

function(enable_strict_warnings target)
  enable_warnings(${target})
  target_compile_options(${target} PRIVATE -Werror)
  message(STATUS "🚨\tWarnings treated as errors for target ${target}")
endfunction()
