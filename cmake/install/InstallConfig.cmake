# Enables standard install paths: lib/, include/, bin/, etc.
include(GNUInstallDirs)

# Provides helpers for writing version/config files
include(CMakePackageConfigHelpers)

# Install compiled library (static or shared)
install(TARGETS math
  EXPORT ${PROJECT_NAME}Targets               # export target for find_package
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} # static libs
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} # shared libs
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Install public headers (recursive copy of include/)
install(
  DIRECTORY ${CMAKE_SOURCE_DIR}/include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Install target exports as <project>Targets.cmake
install(
  EXPORT ${PROJECT_NAME}Targets
  NAMESPACE ${PROJECT_NAME}::  # enables find_package to use <project>::<library>
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

# Generate a <project>ConfigVersion.cmake file
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion # enforces semantic versioning: X.*
)

# Generate <project>Config.cmake from a template
configure_package_config_file(
  "${CMAKE_SOURCE_DIR}/cmake/install/Config.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

# Install config files
install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)
