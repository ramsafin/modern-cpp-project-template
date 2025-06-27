# Apply LTO to a specific target
function(enable_lto target)
  if(CMAKE_INTERPROCEDURAL_OPTIMIZATION)
    set_property(TARGET ${target} PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
    message(STATUS "🔧\tEnabled LTO for target ${target}")
  else()
    message(STATUS "ℹ️\tCMAKE_INTERPROCEDURAL_OPTIMIZATION not enabled globally. Skipping LTO for target ${target}")
  endif()
endfunction()
