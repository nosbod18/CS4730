# Install script for directory: /nfshome/gat7hb/catkin_ws/src/lab7

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/nfshome/gat7hb/catkin_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lab7/action" TYPE FILE FILES "/nfshome/gat7hb/catkin_ws/src/lab7/action/Puma.action")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lab7/msg" TYPE FILE FILES
    "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg"
    "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg"
    "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg"
    "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg"
    "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
    "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg"
    "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lab7/cmake" TYPE FILE FILES "/nfshome/gat7hb/catkin_ws/build/lab7/catkin_generated/installspace/lab7-msg-paths.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/nfshome/gat7hb/catkin_ws/devel/include/lab7")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/nfshome/gat7hb/catkin_ws/devel/share/roseus/ros/lab7")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/nfshome/gat7hb/catkin_ws/devel/share/common-lisp/ros/lab7")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/nfshome/gat7hb/catkin_ws/devel/share/gennodejs/ros/lab7")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/nfshome/gat7hb/catkin_ws/devel/lib/python2.7/dist-packages/lab7")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/nfshome/gat7hb/catkin_ws/devel/lib/python2.7/dist-packages/lab7")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/nfshome/gat7hb/catkin_ws/build/lab7/catkin_generated/installspace/lab7.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lab7/cmake" TYPE FILE FILES "/nfshome/gat7hb/catkin_ws/build/lab7/catkin_generated/installspace/lab7-msg-extras.cmake")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lab7/cmake" TYPE FILE FILES
    "/nfshome/gat7hb/catkin_ws/build/lab7/catkin_generated/installspace/lab7Config.cmake"
    "/nfshome/gat7hb/catkin_ws/build/lab7/catkin_generated/installspace/lab7Config-version.cmake"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/lab7" TYPE FILE FILES "/nfshome/gat7hb/catkin_ws/src/lab7/package.xml")
endif()

