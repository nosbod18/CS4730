# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "lab7: 7 messages, 0 services")

set(MSG_I_FLAGS "-Ilab7:/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg;-Igeometry_msgs:/opt/ros/kinetic/share/geometry_msgs/cmake/../msg;-Inav_msgs:/opt/ros/kinetic/share/nav_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/kinetic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg;-Ivisualization_msgs:/opt/ros/kinetic/share/visualization_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(lab7_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg" NAME_WE)
add_custom_target(_lab7_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lab7" "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg" ""
)

get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg" NAME_WE)
add_custom_target(_lab7_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lab7" "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg" "lab7/PumaResult:actionlib_msgs/GoalID:std_msgs/Header:actionlib_msgs/GoalStatus"
)

get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg" NAME_WE)
add_custom_target(_lab7_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lab7" "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg" ""
)

get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg" NAME_WE)
add_custom_target(_lab7_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lab7" "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg" "lab7/PumaActionResult:actionlib_msgs/GoalStatus:lab7/PumaFeedback:lab7/PumaGoal:lab7/PumaActionFeedback:lab7/PumaActionGoal:lab7/PumaResult:actionlib_msgs/GoalID:std_msgs/Header"
)

get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg" NAME_WE)
add_custom_target(_lab7_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lab7" "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg" "actionlib_msgs/GoalID:std_msgs/Header:lab7/PumaGoal"
)

get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg" NAME_WE)
add_custom_target(_lab7_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lab7" "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg" ""
)

get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg" NAME_WE)
add_custom_target(_lab7_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lab7" "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg" "lab7/PumaFeedback:actionlib_msgs/GoalID:std_msgs/Header:actionlib_msgs/GoalStatus"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
)
_generate_msg_cpp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
)
_generate_msg_cpp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
)
_generate_msg_cpp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
)
_generate_msg_cpp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
)
_generate_msg_cpp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
)
_generate_msg_cpp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
)

### Generating Services

### Generating Module File
_generate_module_cpp(lab7
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(lab7_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(lab7_generate_messages lab7_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_cpp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_cpp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_cpp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg" NAME_WE)
add_dependencies(lab7_generate_messages_cpp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_cpp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_cpp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_cpp _lab7_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lab7_gencpp)
add_dependencies(lab7_gencpp lab7_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lab7_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
)
_generate_msg_eus(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
)
_generate_msg_eus(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
)
_generate_msg_eus(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
)
_generate_msg_eus(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
)
_generate_msg_eus(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
)
_generate_msg_eus(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
)

### Generating Services

### Generating Module File
_generate_module_eus(lab7
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(lab7_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(lab7_generate_messages lab7_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_eus _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_eus _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_eus _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg" NAME_WE)
add_dependencies(lab7_generate_messages_eus _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_eus _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_eus _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_eus _lab7_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lab7_geneus)
add_dependencies(lab7_geneus lab7_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lab7_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
)
_generate_msg_lisp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
)
_generate_msg_lisp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
)
_generate_msg_lisp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
)
_generate_msg_lisp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
)
_generate_msg_lisp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
)
_generate_msg_lisp(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
)

### Generating Services

### Generating Module File
_generate_module_lisp(lab7
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(lab7_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(lab7_generate_messages lab7_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_lisp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_lisp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_lisp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg" NAME_WE)
add_dependencies(lab7_generate_messages_lisp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_lisp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_lisp _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_lisp _lab7_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lab7_genlisp)
add_dependencies(lab7_genlisp lab7_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lab7_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
)
_generate_msg_nodejs(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
)
_generate_msg_nodejs(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
)
_generate_msg_nodejs(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
)
_generate_msg_nodejs(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
)
_generate_msg_nodejs(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
)
_generate_msg_nodejs(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
)

### Generating Services

### Generating Module File
_generate_module_nodejs(lab7
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(lab7_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(lab7_generate_messages lab7_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_nodejs _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_nodejs _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_nodejs _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg" NAME_WE)
add_dependencies(lab7_generate_messages_nodejs _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_nodejs _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_nodejs _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_nodejs _lab7_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lab7_gennodejs)
add_dependencies(lab7_gennodejs lab7_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lab7_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
)
_generate_msg_py(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
)
_generate_msg_py(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
)
_generate_msg_py(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
)
_generate_msg_py(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
)
_generate_msg_py(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
)
_generate_msg_py(lab7
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/opt/ros/kinetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/kinetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
)

### Generating Services

### Generating Module File
_generate_module_py(lab7
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(lab7_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(lab7_generate_messages lab7_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_py _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_py _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_py _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaAction.msg" NAME_WE)
add_dependencies(lab7_generate_messages_py _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionGoal.msg" NAME_WE)
add_dependencies(lab7_generate_messages_py _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaResult.msg" NAME_WE)
add_dependencies(lab7_generate_messages_py _lab7_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/nfshome/gat7hb/catkin_ws/devel/share/lab7/msg/PumaActionFeedback.msg" NAME_WE)
add_dependencies(lab7_generate_messages_py _lab7_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lab7_genpy)
add_dependencies(lab7_genpy lab7_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lab7_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lab7
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(lab7_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET nav_msgs_generate_messages_cpp)
  add_dependencies(lab7_generate_messages_cpp nav_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(lab7_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(lab7_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET visualization_msgs_generate_messages_cpp)
  add_dependencies(lab7_generate_messages_cpp visualization_msgs_generate_messages_cpp)
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(lab7_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/lab7
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(lab7_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET nav_msgs_generate_messages_eus)
  add_dependencies(lab7_generate_messages_eus nav_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(lab7_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(lab7_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET visualization_msgs_generate_messages_eus)
  add_dependencies(lab7_generate_messages_eus visualization_msgs_generate_messages_eus)
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(lab7_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/lab7
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(lab7_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET nav_msgs_generate_messages_lisp)
  add_dependencies(lab7_generate_messages_lisp nav_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(lab7_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(lab7_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET visualization_msgs_generate_messages_lisp)
  add_dependencies(lab7_generate_messages_lisp visualization_msgs_generate_messages_lisp)
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(lab7_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/lab7
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(lab7_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET nav_msgs_generate_messages_nodejs)
  add_dependencies(lab7_generate_messages_nodejs nav_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(lab7_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(lab7_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET visualization_msgs_generate_messages_nodejs)
  add_dependencies(lab7_generate_messages_nodejs visualization_msgs_generate_messages_nodejs)
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(lab7_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lab7
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(lab7_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET nav_msgs_generate_messages_py)
  add_dependencies(lab7_generate_messages_py nav_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(lab7_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(lab7_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET visualization_msgs_generate_messages_py)
  add_dependencies(lab7_generate_messages_py visualization_msgs_generate_messages_py)
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(lab7_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
