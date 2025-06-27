# Applies standard warning flags (-Wall, -Wextra, etc.)
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
  else()
    message(STATUS "Skipping warnings: unsupported compiler ${CMAKE_CXX_COMPILER_ID}")
  endif()
endfunction()

# Applies warnings and treats them as errors (-Werror)
function(enable_strict_warnings target)
  enable_warnings(${target})
  target_compile_options(${target} PRIVATE -Werror)
  message(STATUS "🚨\tWarnings treated as errors for target ${target}")
endfunction()
