add_library(${PROJECT_NAME}_library STATIC
  library.cpp
)

add_library(${PROJECT_NAME}::library ALIAS ${PROJECT_NAME}_library)

target_include_directories(${PROJECT_NAME}_library
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

target_compile_features(${PROJECT_NAME}_library PUBLIC cxx_std_${CMAKE_CXX_STANDARD})

enable_strict_warnings(${PROJECT_NAME}_library)
enable_sanitizers(${PROJECT_NAME}_library)
enable_coverage(${PROJECT_NAME}_library)
