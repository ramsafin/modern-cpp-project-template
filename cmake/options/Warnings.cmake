include_guard(GLOBAL)

# Internal: Apply standard warnings
function(enable_warnings target)
  if(NOT TARGET ${target})
    message(WARNING "Target '${target}' does not exist. Skipping warnings.")
    return()
  endif()

  if(NOT ENABLE_WARNINGS)
    message(STATUS "Warnings are disabled by user for '${target}'")
    return()
  endif()

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(${target} PRIVATE
      -Wall
      -Wextra
      -Wpedantic
      -Wconversion
      -Wsign-conversion
    )
    message(STATUS "Enabled GNU/Clang warnings for '${target}'")

  elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    target_compile_options(${target} PRIVATE
      /W4           # High warning level
      /permissive-  # Stricter standard compliance
    )
    message(STATUS "Enabled MSVC warnings for '${target}'")

  else()
    message(WARNING "Unknown compiler '${CMAKE_CXX_COMPILER_ID}' — no warnings set for '${target}'")
  endif()
endfunction()

# Internal: Apply warnings and treat them as errors
function(enable_strict_warnings target)
  enable_warnings(${target})

  if(NOT ENABLE_STRICT_WARNINGS)
    message(STATUS "Strict warnings (Werror) disabled by user for '${target}'")
    return()
  endif()

  if(NOT TARGET ${target})
    return()
  endif()

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    target_compile_options(${target} PRIVATE -Werror)
    message(STATUS "Warnings treated as errors for '${target}'")

  elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
    target_compile_options(${target} PRIVATE /WX)
    message(STATUS "Warnings treated as errors (MSVC) for '${target}'")

  endif()
endfunction()
