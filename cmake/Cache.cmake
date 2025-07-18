# Cache.cmake — find and wire up ccache if ENABLE_CACHE is ON

if(ENABLE_CACHE)
  find_program(CCACHE_PROGRAM NAMES ccache)
  if(CCACHE_PROGRAM)
    message(STATUS "Found ccache: ${CCACHE_PROGRAM}")
    set(CMAKE_C_COMPILER_LAUNCHER   "${CCACHE_PROGRAM}" CACHE STRING "" FORCE)
    set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}" CACHE STRING "" FORCE)
  else()
    message(WARNING "ccache requested but not found → continuing without caching")
  endif()
endif()
