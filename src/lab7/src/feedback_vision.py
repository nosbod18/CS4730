#!/usr/bin/env python
import rospy
import numpy as np
import math
import tf
import sys
from math import radians, degrees
from geometry_msgs.msg import Point, Twist, Pose2D, Transform, Pose, Quaternion
from nav_msgs.msg import Odometry
from ar_pose.msg import ARMarker, ARMarkers
from average import Avg_xyz, Avg_rpy # calibration msg
#from lab7.msg import PumaAction, PumaGoal


###############################################################################

rHg = np.identity(4) # error
wHr = np.identity(4)
wHg = np.identity(4)
cHr = np.identity(4)
cHm = np.identity(4)
mHg = np.identity(4)

K_alpha = 1.5
K_rho   = 0.7
K_beta  = -0.5

first_ar = True
first_odom = True
first_imu = True

ar_bias = 0.0
imu_bias = 0.0

marker_in_view = True

threshold_v = 0.05
threshold_w = 0.1

pose = Pose2D()

pub = None


###############################################################################

def get_wHm(marker_id):
    if marker_id == 1:
        return np.array([
            [0,-1, 0, 0.485],
            [1, 0, 0, 2.815],
            [0, 0, 1,     0],
            [0, 0, 0,     1]
        ])
    elif marker_id == 2:
        return np.array([
            [ 0, 1, 0, 0.485],
            [-1, 0, 0,-0.255],
            [ 0, 0, 1,     0],
            [ 0, 0, 0,     1]
        ])
    elif marker_id == 3:
        return np.array([
            [1, 0, 0, 2.39],
            [0, 1, 0,    0],
            [0, 0, 1,    0],
            [0, 0, 0,    1]
        ])
    elif marker_id == 4:
        return np.array([
            [-1, 0, 0,-0.33],
            [ 0,-1, 0,    0],
            [ 0, 0, 1,    0],
            [ 0, 0, 0,    1]
        ])


def set_mHg(x, y, theta):
    global mHg

    mHg = np.array([
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


def set_wHg(marker_id):
    global wHg, mHg

    wHm = get_wHm(marker_id)
    wHg = np.matmul(wHm, mHg)


###############################################################################

def ar_callback(msg):
    global cHm, first_ar, marker_in_view

    if len(msg.markers) == 0:
        marker_in_view = False
        return

    msg.markers.sort(key=lambda x: x.confidence, reverse=True)

    if msg.markers[0].confidence < 20:
        marker_in_view = False
        return

    marker_in_view = True

    p = msg.markers[0].pose.pose.position
    o = msg.markers[0].pose.pose.orientation
    yaw = tf.transformations.euler_from_quaternion([o.x, o.y, o.z, o.w])[2]

    cHm = np.array([
        [np.cos(yaw),-np.sin(yaw), 0, p.x],
        [np.sin(yaw), np.cos(yaw), 0, p.y],
        [0,           0,           1, p.z],
        [0,           0,           0, 1]
    ])

    if first_ar:
        first_ar = False


def odom_callback(msg):
    global pose, first_odom

    pose.x = msg.pose.pose.position.x
    pose.y = msg.pose.pose.position.y

    if first_odom:
        first_odom = False


def imu_callback(msg):
    global pose, first_imu

    rpy = tf.transformations.euler_from_quaternion([msg.x, msg.y, msg.z, msg.w])
    pose.theta = rpy[2]

    if first_imu:
        first_imu = False


###############################################################################

def update_rHg():
    global rHg, cHr, cHm, mHg, wHr, wHg, pose, marker_in_view

    if marker_in_view:
        rHg = np.matmul(np.matmul(np.linalg.inv(cHr), cHm), mHg)
    else:
        wHr = np.array([
            [np.cos(pose.theta), -np.sin(pose.theta), 0, pose.x],
            [np.sin(pose.theta),  np.cos(pose.theta), 0, pose.y],
            [0,               0,                      1, 0],
            [0,               0,                      0, 1]
        ])
        rHg = np.matmul(np.linalg.inv(wHr), wHg)


def update_vw():
    global v, w, K_rho, K_alpha, K_beta, rho, alpha, beta

    v = K_rho * rho
    w = (K_alpha * alpha) + (K_beta * beta)


def update_rab():
    global rho, alpha, beta, rHg

    x = rHg[0, 3]
    y = rHg[1, 3]
    theta = tf.transformations.euler_from_matrix(rHg[:3,:3], 'rxyz')[2]

    rho = np.sqrt(x**2 + y**2)
    alpha = math.atan2(-y, -x) - theta
    alpha = alpha % (2 * math.pi)

    # Clamp alpha between -pi, pi
    if (alpha > math.pi):
        alpha -= 2 * math.pi

    beta = -alpha - theta


###############################################################################

def move(x, y, theta, marker_id):
    global rHg, first_ar, first_imu, first_odom, pub

    rospy.Rate(10)

    set_cHr(Avg_xyz[0], Avg_xyz[1], Avg_xyz[2], Avg_rpy[0], Avg_rpy[1], Avg_rpy[2])
    set_mHg(x, y, theta)
    set_wHg(marker_id)

    move = Twist()

    while not rospy.is_shutdown():
        if not first_ar or not (first_imu and first_odom):
            update_rHg()
            update_rab()
            update_vw()

            move.linear.x  = v
            move.angular.z = w
            pub.publish(move)

            #compared_angle = theta - pose.theta
            #compared_angle = (compared_angle + np.pi) % (2 * np.pi) - np.pi

            if np.allclose(rHg, np.identity(4), rtol=0.01):
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
    pub = rospy.Publisher('/feedback_vision/cmd_vel', Twist, queue_size=1)

    #client = actionlib.SimpleActionClient('puma', PumaAction)
    #print('client: waiting for server...')
    #client.wait_for_server()

    ###########################################

    # First leg
    move(0.245, 0, 180, 3) # drive to marker
    move(0.245, 0, -90, 3) # turn
    move(0.245, -0.685, -90, 3) # drive to pipe

    return

    ###########################################

    #goal = PumaGoal()
    #goal.puma_id = 1

    #print('client: request sent to puma #1, waiting for reply...')
    #client.send_goal(goal)
    #client.wait_for_result()
    #print('client: object received')

    ###########################################

    print('client: driving...')
    move(0.245, -0.685, 90, 3) # turn
    move(0.245, 0, 90, 3) # drive to marker 3
    move(0.245, 0, 0, 3) # turn

    move(0.80, 0, 180, 4) # drive to marker 2
    move(0.80, 0, 90, 4) # turn

    move(0.245, 0, 180, 1) # drive to marker 1
    move(0.245, 0, -90, 1) # turn
    move(0.245, -0.685, -90, 1) # drive to pipe

    ###########################################

    #goal.puma_id = 2

    #print('client: request sent to puma #2, waiting for reply...')
    #client.send_goal(goal)
    #client.wait_for_result()
    #print('client: object received')

    ###########################################

    print('client: driving...')
    move(0.245, -0.685, 90, 3) # turn
    move(0.245, 0, 90, 3) # drive to marker 1
    move(0.245, 0, 0, 3) # turn

    move(0.245, 0, 180, 2) # drive to marker 2
    move(0.245, 0, -90, 2) # turn

    move(0.245, 0, 180, 4) # drive to marker 4
    move(0.245, 0, 0, 4) # turn

    ###########################################
