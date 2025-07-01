  add_executable(${PROJECT_NAME}_app main.cpp)
  target_link_libraries(${PROJECT_NAME}_app PRIVATE ${PROJECT_NAME}::library)

  enable_strict_warnings(${PROJECT_NAME}_app)
  enable_sanitizers(${PROJECT_NAME}_app)
