# Link Time Optimization (LTO)
add_library(lto INTERFACE)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang|GNU")
  target_compile_options(lto INTERFACE -flto)
  target_link_options(lto INTERFACE -flto)
else()
  message(WARNING "LTO not configured for compiler: ${CMAKE_CXX_COMPILER_ID}")
endif()

# Function to apply lto
function(enable_lto target)
  if(CMAKE_INTERPROCEDURAL_OPTIMIZATION)
    target_link_libraries(${target} PRIVATE lto)
    message(STATUS "✅ Enabled LTO for target: ${target}")
  endif()
endfunction()
