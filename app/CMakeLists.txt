include(FetchContent)


FetchContent_Declare(
  spdlog
  URL https://github.com/gabime/spdlog/archive/refs/tags/v1.15.3.zip
  DOWNLOAD_EXTRACT_TIMESTAMP true
)

FetchContent_MakeAvailable(spdlog)

add_executable(${PROJECT_NAME}_app main.cpp)

target_link_libraries(${PROJECT_NAME}_app
  PRIVATE ${PROJECT_NAME}::library spdlog::spdlog
)

# mark spdlog headers as system includes to avoid warnings (-Werror)
get_target_property(_spdlog_includes spdlog::spdlog INTERFACE_INCLUDE_DIRECTORIES)
target_include_directories(${PROJECT_NAME}_app
  SYSTEM PRIVATE ${_spdlog_includes}
)

enable_strict_warnings(${PROJECT_NAME}_app)
enable_sanitizers(${PROJECT_NAME}_app)
