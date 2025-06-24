add_library(arithmetic STATIC
  arithmetic.cpp
)

target_include_directories(arithmetic
  PUBLIC ${PROJECT_SOURCE_DIR}/include
)

if(TARGET sanitizers)
  target_link_libraries(arithmetic PUBLIC sanitizers)
endif()
