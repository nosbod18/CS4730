#!/usr/bin/env python
import rospy
import numpy as np
import math
import tf
import sys
from math import radians, degrees
from geometry_msgs.msg import Point, Twist, Pose2D, Transform, Pose, Quaternion
from nav_msgs.msg import Odometry

"""
Global variables
"""

"""
TODO: Set up the feedback gains by replacing None.
"""

GAIN_ALPHA = None
GAIN_RHO = None
GAIN_BETA = None


v = None
w = None

rho = 0.0
alpha = 0.0
beta = 0.0
theta = 0.0

odom_not_received = True
imu_not_received = True
first_imu = True
imu_bias = 0

goal_to_world = np.identity(4)
robot_to_world = np.identity(4)
robot_to_goal = np.identity(4)

pose = Pose2D()

pos_thresh = 0.05
orient_thresh = 0.05


"""
Utility functions
"""
# FIRST FUNCTION:
# This function is the callback for the subscriber.
# It returns the odometry information as the robot moves along its path toward the goal pose
def odom_callback(msg):
    global pose, odom_not_received, robot_to_world

    #print("x: {} - y: {} - z: {}".format(pose.position.x, pose.position.y, pose.position.z))

    #quat = (
    #    msg.pose.pose.orientation.x,
    #    msg.pose.pose.orientation.y,
    #    msg.pose.pose.orientation.z,
    #    msg.pose.pose.orientation.w
    #)
    #euler = tf.transformations.euler_from_quaternion(quat)

    ##print("r: {} - p: {} - y: {}".format(euler[0], euler[1], euler[2]))

    #pose.orientation.x = msg.pose.pose.orientation.x
    #pose.orientation.y = msg.pose.pose.orientation.y
    #pose.orientation.z = msg.pose.pose.orientation.z
    #pose.orientation.w = msg.pose.pose.orientation.w

    #rotation_matrix = np.array([[math.cos(euler[2]), -math.sin(euler[2]), 0],
    #                            [math.sin(euler[2]), math.cos(euler[2]), 0],
    #                            [0, 0, 1]])

    #robot_to_world[:3,:3] = rotation_matrix
    robot_to_world[:3,3] = np.array([msg.pose.pose.position.x,
                                     msg.pose.pose.position.y,
                                     msg.pose.pose.position.z])

    #print("robot_to_world:\n{}".format(robot_to_world))



    pose.x = msg.pose.pose.position.x
    pose.y = msg.pose.pose.position.y
    #pose.theta = euler[2]
    #print("From odometry:\nx: {} - y: {} - yaw: {}".format(pose.x, pose.y, euler[2]))

    # check that the odometry was received
    if odom_not_received: odom_not_received = False


def imu_callback(msg):
    global pose, imu_not_received, first_imu, imu_bias

    euler = list(tf.transformations.euler_from_quaternion([msg.x, msg.y, msg.z, msg.w]))

    if first_imu == True:
        imu_bias = euler[2]
        first_imu = False

    euler[2] -= imu_bias

    robot_to_world[:3,:3] = np.array([[math.cos(euler[2]), -math.sin(euler[2]), 0],
                                      [math.sin(euler[2]),  math.cos(euler[2]), 0],
                                      [0, 0, 1]])

    pose.theta = euler[2]

    if imu_not_received: imu_not_received = False


# this function normalizes the angles between -pi and +pi
def normalize_angles(angle):
    angle = angle % (2*math.pi)
    if (angle > math.pi):
        angle -= 2*math.pi
    return angle


# SECOND FUNCTION:
# This function calculatesthe 3 parameters of the controller
# These parameters are used to perform the feed-back control loop
def calculate_rho_alpha_beta():
    global rho, theta, alpha, beta

    position = Point(); orientation = Quaternion()

    rotation_matrix = np.identity(4)
    rotation_matrix[:3,:3] = robot_to_goal[:3,:3]

    euler = tf.transformations.euler_from_matrix(rotation_matrix)

    position.x = robot_to_goal[0,3]
    position.y = robot_to_goal[1,3]
    position.z = robot_to_goal[2,3]

    theta = euler[2]
    rho = math.sqrt(math.pow(position.x, 2) + (math.pow(position.y, 2)))
    alpha = math.atan2(-position.y, -position.x) - theta
    alpha = normalize_angles(alpha)

    if (alpha > math.pi/2):
        alpha -= math.pi
    elif (alpha <= -math.pi):
        alpha += math.pi

    beta = -alpha - theta

    #print("theta: {}, rho: {}, alpha: {}, beta: {}".format(theta, rho, alpha, beta))


# THIRD FUNCTION:
# This function finds the transformation between the robot and the robot
# It mainly builds the transformation to be tracked as the robot moves
def initialize_goal_to_world(x, y, theta):
    if odom_not_received and imu_not_received:

        position_vector = Point()
        position_vector.x = x
        position_vector.y = y
        position_vector.z = 0.0

        rotation_matrix = np.array([[math.cos(theta), -math.sin(theta), 0],
                                    [math.sin(theta), math.cos(theta), 0],
                                    [0, 0, 1]])

        goal_to_world[:3,:3] = rotation_matrix
        goal_to_world[:3,3] = np.array([position_vector.x,
                                        position_vector.y,
                                        position_vector.z])

        print("goal_to_world:\n{}".format(goal_to_world))


# FOURTH FUNCTION:
# This function finds the linear and angular velocities based on the polar coordinates
def calculate_velocities():
    global rho, theta, alpha, beta
    global GAIN_RHO, GAIN_ALPHA, GAIN_BETA, v, w

    v = (GAIN_RHO*rho)
    w = (GAIN_ALPHA*alpha) + (GAIN_BETA*beta)

    #print("v: {} / w: {}".format(v, w))

# clean chutdown of the node
def clean_shutdown():
    twist = Twist()
    twist.linear.x = 0.0
    twist.angular.z = 0.0
    cmd_vel_pub.publish(twist)

"""
Main function
"""
if __name__=='__main__':

    # declare us to be a node to be shut down safely
    rospy.on_shutdown(clean_shutdown)
    rospy.init_node('controller')


    """
    TODO: Set up your publisher and subscriber.by replacing None
    """
    odom_sub = rospy.Subscriber('/odom', Odometry, odom_callback)
    imu_sub = rospy.Subscriber('/imu', Quaternion, imu_callback)
    cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)


    # Take input from the user
    args = rospy.myargv(argv=sys.argv)

    if len(args) != 7:
        print("Usage: node.py <x> <y> <theta> <K_alpha> <K_rho> <K_beta>")
        sys.exit(1)

    # Take the input goal from the user
    goal = Pose2D()
    goal.x = float(args[1]);
    goal.y = float(args[2]);
    goal.theta = math.radians(float(args[3]))
    GAIN_ALPHA = float(args[4])
    GAIN_RHO = float(args[5])
    GAIN_BETA = float(args[6])


    """
    TODO: Think about how you are going to save the paths to reproduce the figures
    """


    # set the rate
    rate = rospy.Rate(10)


    # initialize the goal to world transformation
    initialize_goal_to_world(goal.x, goal.y, goal.theta)

    while not rospy.is_shutdown():
        if odom_not_received == False and imu_not_received == False:
            print("")
            rospy.loginfo("Feedback control - go to goal behavior")

            # update the transformation from robot to goal as the robot is moving
            robot_to_goal = np.dot(np.linalg.inv(goal_to_world), robot_to_world)

            # calculate the polar coordinates
            calculate_rho_alpha_beta()

            # calculate the linear and angular velocities
            calculate_velocities()

            print("v: {} / w: {}".format(v, w))

            print("\nDesired Robot Pose: ")
            print("desired_x: {}".format(goal.x))
            print("desired_y: {}".format(goal.y))
            print("desired_theta: {}".format(goal.theta))

            print("\nCurrent Robot Pose: ")
            print("current_x: {}".format(pose.x))
            print("current_y: {}".format(pose.y))
            print("current_theta: {}".format(pose.theta))

            # set the velocities in the twist message and publish
            twist = Twist()
            twist.linear.x = v
            twist.angular.z = w
            cmd_vel_pub.publish(twist)

            # break out of the loop when the threshold is met
            #pos_thresh = 0.005
            #orient_thresh = 0.15

            # orientation angle comparison is a little more involved
            # this is because angle can fall in any quadrand
            compared_angle = goal.theta - pose.theta
            compared_angle = (compared_angle+np.pi)%(2*np.pi) - np.pi
            print("error in x: {}".format(abs(goal.x - pose.x)))
            print("error in y: {}".format(abs(goal.y - pose.y)))
            print("error in theta: {}".format(compared_angle))

            if abs(goal.x - pose.x) <= pos_thresh and abs(goal.y - pose.y) <= pos_thresh and abs(compared_angle) <= orient_thresh:
                twist.linear.x = 0
                twist.angular.z = 0
                cmd_vel_pub.publish(twist)
                break

            # sleep a little
            rate.sleep()

