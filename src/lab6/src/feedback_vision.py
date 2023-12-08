#!/usr/bin/env python

import rospy
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist, Quaternion
from ar_pose.msg import ARMarker, ARMarkers
import tf
import numpy as np
import sys
import math
from average import Avg_xyz, Avg_rpy # calibration data


###############################################################################

rHg = np.identity(4) # error
iHr = np.identity(4)
iHg = np.identity(4)
cHr = np.identity(4)
cHm = np.identity(4)
mHg = np.identity(4)

K_rho = 3
K_alpha = 0.2
K_beta = -0.2
gain = [K_rho, K_alpha, K_beta]

rho = 0
alpha = 0
beta = 0
v = 0
w = 0

ar_received = False
first_ar = True
ar_bias = 0
odom_received = Falseavg_z
imu_received = False
first_imu = True
imu_bias = 0

marker_in_view = False

threshold_linear = 0.05
threshold_angular = 0.1 

xyz = [0, 0, 0]
rpy = [0, 0, 0]
error = [0, 0, 0]

pub = None


###############################################################################

def set_iHg(x, y, theta):
    global iHg
    iHg = np.array([
        [np.cos(theta),-np.sin(theta), 0, x],
        [np.sin(theta), np.cos(theta), 0, y],
        [0,             0,             1, 0],
        [0,             0,             0, 1]
    ])


def set_cHr(x, y, z, roll, pitch, yaw):
    global cHr

    Rx = np.array([
        [1, 0,            0],
        [0, np.cos(roll),-np.sin(roll)],
        [0, np.sin(roll), np.cos(roll)]
    ])

    Ry = np.array([
        [np.cos(yaw), 0,-np.sin(yaw)],
        [0,           1, 0],
        [np.sin(yaw), 0, np.cos(yaw)]
    ])

    Rz = np.array([
        [np.cos(roll),-np.sin(roll), 0],
        [np.sin(roll), np.cos(roll), 0],
        [0,            0,            1]
    ])

    cHr[:3,:3] = np.matmul(np.matmul(Rz, Ry), Rx)
    cHr[:3, 3] = [x, y, z]


###############################################################################

def ar_callback(data):
    global xyz, rpy, first_ar, ar_bias, ar_received, marker_in_view

    if len(data.markers) > 0:
        marker_in_view = True
        for marker in data.markers:
            orientation = marker.pose.pose.orientation
            orientation = [orientation.x, orientation.y, orientation.z, orientation.w]
            maybe_rpy = list(tf.transformations.euler_from_quaternion(orientation))

            position = marker.pose.pose.position
            xyz = [position.x, position.y, position.z]
    else:
        marker_in_view = False
        return

    if first_ar == True:
        ar_bias = rpy[2]
        first_ar = False

    rpy[2] -= ar_bias
    ar_received = True


def odom_callback(data):
    global xyz, odom_received

    if marker_in_view:
        return

    position = data.pose.pose.position
    xyz = [position.x, position.y, position.z]
    odom_received = True


def imu_callback(data):
    global rpy, imu_received, first_imu, imu_bias

    if marker_in_view:
        return

    rpy = list(tf.transformations.euler_from_quaternion([data.x, data.y, data.z, data.w]))

    if first_imu == True:
        imu_bias = rpy[2]
        first_imu = False

    rpy[2] -= imu_bias
    imu_received = True


###############################################################################

def update_rho_alpha_beta():
    global rHg, rho, alpha, beta

    x = rHg[0, 3]
    y = rHg[1, 3]
    theta = tf.transformations.euler_from_matrix(rHg[:3,:3], 'rxyz')[2]

    rho = np.sqrt(x**2 + y**2)
    alpha = math.atan2(-y, -x) - theta
    alpha = alpha % (2 * math.pi)

    if (alpha > math.pi):
        alpha -= 2*math.pi

    beta = -alpha - theta


def update_vw():
    global v, w, rho, alpha, beta, gain
    v = gain[0] * rho
    w = (gain[1] * alpha) + (gain[2] * beta)


def update_rHg():
    global iHr, rHg, ar_received, odom_received, imu_received, marker_in_view

    iHr = np.array([
        [np.cos(rpy[2]), -np.sin(rpy[2]), 0, xyz[0]],
        [np.sin(rpy[2]),  np.cos(rpy[2]), 0, xyz[1]],
        [0,               0,              1, xyz[2]],
        [0,               0,              0, 1]
    ])

    if marker_in_view:
        rHg = np.matmul(np.matmul(np.linalg.inv(cHr), cHm), mHg)
    else:
        rHg = np.matmul(np.linalg.inv(iHr), iHg)

    ar_received = False
    odom_received = False
    imu_received = False


###############################################################################

def move(x_G, y_G, theta_G):
    global v, w, ar_received, xyz, rpy, threshold_linear, threshold_angular, pub, marker_in_view

    rate = rospy.Rate(10)

    theta_G = math.radians(theta_G)
    set_iHg(x_G, y_G, theta_G)
    set_cHr(Avg_xyz[0], Avg_xyz[1], Avg_xyz[2], Avg_rpy[0], Avg_rpy[1], Avg_rpy[2]) # set cHr

    move = Twist()

    while not rospy.is_shutdown():
        if ar_received or (imu_received and odom_received):
            update_rHg()
            update_rho_alpha_beta()
            update_vw()

            print(marker_in_view)
            print(v, w)

            move.linear.x = v
            move.angular.z = w
            pub.publish(move)

            compared_angle = theta_G - rpy[2]
            compared_angle = (compared_angle + np.pi) % (2 * np.pi) - np.pi

            if abs(x_G - xyz[0]) <= threshold_linear and abs(y_G - xyz[1]) <= threshold_linear and abs(compared_angle) <= threshold_angular:
                error = [abs(x_G - xyz[0]), abs(y_G - xyz[1]), abs(compared_angle)]

                stop = Twist()
                stop.linear.x = 0
                stop.angular.z = 0

                pub.publish(stop)
                break


###############################################################################

if __name__ == '__main__':
    rospy.init_node('feedback_vision', anonymous=True)
    rospy.Subscriber('/ar_pose_marker', ARMarkers, ar_callback)
    rospy.Subscriber('/odom', Odometry, odom_callback)
    rospy.Subscriber('/imu', Quaternion, imu_callback)
    pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)

    move(1, 0, 0)

