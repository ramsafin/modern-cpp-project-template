# Standard warnings
add_library(warnings INTERFACE)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
  target_compile_options(warnings INTERFACE
    -Wall
    -Wextra
    -Wpedantic
    -Wconversion
    -Wsign-conversion
  )
endif()

# Warnings as errors
add_library(strict_warnings INTERFACE)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
  target_compile_options(strict_warnings INTERFACE -Werror)
  target_link_libraries(strict_warnings PRIVATE warnings)
endif()

# Function to apply warnings
function(enable_warnings target)
  target_link_libraries(${target} PRIVATE warnings)
  message(STATUS "⚠️ Enabled warnings for target ${target}")
endfunction()

# Function to apply warnings as errors
function(enable_strict_warnings target)
  target_link_libraries(${target} PRIVATE strict_warnings)
  message(STATUS "⚠️ Enabled warnings as errors for target ${target}")
endfunction()
