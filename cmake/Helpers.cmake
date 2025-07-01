#–– Helpers.cmake –– functions to apply flags to targets

# Compiler warnings
function(enable_warnings target)
  if(NOT ENABLE_WARNINGS)
    message(STATUS "Skipping warnings for '${target}' (ENABLE_WARNINGS=OFF)")
    return()
  endif()

  if(NOT TARGET ${target})
    message(WARNING "Target '${target}' not found; cannot enable warnings.")
    return()
  endif()

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    message(STATUS "Enabling warnings for '${target}': ${PROJECT_WARNING_FLAGS}")
    target_compile_options(${target} PRIVATE ${PROJECT_WARNING_FLAGS})
  else()
    message(WARNING "Compiler '${CMAKE_CXX_COMPILER_ID}' not supported; no warnings for '${target}'")
  endif()
endfunction()

function(enable_strict_warnings target)
  if(NOT ENABLE_STRICT_WARNINGS)
    message(STATUS "Strict warnings disabled for '${target}' (ENABLE_STRICT_WARNINGS=OFF)")
    return()
  endif()

  if(NOT ENABLE_WARNINGS)
    message(STATUS "ENABLE_STRICT_WARNINGS=ON implies ENABLE_WARNINGS; enabling warnings for '${target}'")
    # We force-enable warnings so that -Werror has something to convert
    set(ENABLE_WARNINGS TRUE CACHE BOOL "auto-enabled by strict warnings" FORCE)
  endif()

  if(NOT TARGET ${target})
    message(WARNING "Target '${target}' not found. cannot treat warnings as errors.")
    return()
  endif()

  enable_warnings(${target})

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    message(STATUS "Treating warnings as errors for '${target}'")
    target_compile_options(${target} PRIVATE -Werror)
  else()
    message(WARNING "Compiler '${CMAKE_CXX_COMPILER_ID}' not supported; no warnings as errors for '${target}'")
  endif()
endfunction()

# Sanitizers
function(enable_sanitizers target)
  if(NOT TARGET ${target})
    message(WARNING "Target '${target}' not found; skipping sanitizers.")
    return()
  endif()

  if(NOT (ENABLE_ASAN OR ENABLE_UBSAN))
    message(STATUS "No sanitizer enabled for '${target}' (all sanitizers OFF)")
    return()
  endif()

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    set(_flags)
    if(ENABLE_ASAN)
      list(APPEND _flags ${PROJECT_ASAN_FLAGS})
    endif()
    if(ENABLE_UBSAN)
      list(APPEND _flags ${PROJECT_UBSAN_FLAGS})
    endif()

    list(APPEND _flags -O1 -g)
    message(STATUS "Enabling sanitizers for '${target}': ${_flags}")

    target_compile_options(${target} PUBLIC ${_flags})
    target_link_options(${target} PUBLIC ${_flags})
  else()
    message(WARNING "Sanitizers only supported on Clang/GNU; skipping for '${target}'")
  endif()
endfunction()

# Coverage
function(enable_coverage target)
  if(NOT TARGET ${target})
    message(WARNING "Target '${target}' not found; skipping coverage.")
    return()
  endif()

  if(NOT ENABLE_COVERAGE)
    message(STATUS "Coverage disabled for '${target}' (ENABLE_COVERAGE=OFF)")
    return()
  endif()

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
    message(STATUS "Enabling coverage for '${target}'")
    target_compile_options(${target} PRIVATE ${PROJECT_COVERAGE_FLAGS} -O0 -g)
    target_link_options(${target} PRIVATE ${PROJECT_COVERAGE_FLAGS})
  else()
    message(WARNING "Coverage only supported on Clang/GNU; skipping for '${target}'")
  endif()
endfunction()
