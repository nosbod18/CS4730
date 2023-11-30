#!/usr/bin/env python

import rospy
import cv2 as cv
import numpy as np
import actionlib
import time
from lab7.msg import PumaAction, PumaGoal

PUMA_ID = 1

P_l = None
K_l = None
dist_l = None

P_r = None
K_r = None
dist_r = None

server = None


def find_uv(image_path):
    img = cv.imread(image_path)
    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

    _, thresh = cv.threshold(gray, 175, 255, cv.THRESH_BINARY_INV)

    # Fill holes in image
    thresh2 = thresh.copy()
    h, w = thresh.shape[:2]
    mask = np.zeros((h + 2, w + 2), np.uint8)
    cv.floodFill(thresh2, mask, (0, 0), 255)
    filled_inv = cv.bitwise_not(thresh2)
    filled = thresh | filled_inv

    _, contours, hierarchy = cv.findContours(filled, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)

    uv = []

    for c in contours:
        M = cv.moments(c)
        u = int(M["m10"] / M["m00"]) if M["m00"] != 0 else 0
        v = int(M["m01"] / M["m00"]) if M["m00"] != 0 else 0
        uv.append([u, v])
        cv.circle(img, (u, v), 5, (0, 0, 255), -1)

    return np.array([uv], dtype=np.float32)


def find_xyz(uv_l, uv_r, P_l, P_r):
    A = np.array([
        P_r[0,0:3] - uv_r[0] * P_r[2,0:3],
        P_r[1,0:3] - uv_r[1] * P_r[2,0:3],
        P_l[0,0:3] - uv_l[0] * P_l[2,0:3],
        P_l[1,0:3] - uv_l[1] * P_l[2,0:3]
    ])

    b = np.array([
        uv_r[0] * P_r[2,3] - P_r[0,3],
        uv_r[1] * P_r[2,3] - P_r[1,3],
        uv_l[0] * P_l[2,3] - P_l[0,3],
        uv_l[1] * P_l[2,3] - P_r[1,3]
    ])

    return np.matmul(np.linalg.pinv(A), b)


def locate_objects(goal):
    global K_l, P_l, dist_l, K_r, P_r, dist_r

    if goal.puma_id != PUMA_ID:
        return

    print('server: goal recieved, executing script...')

    uv_l = find_uv('images/left00.ppm')
    uv_r = find_uv('images/right00.ppm')

    uv_l = cv.undistortPoints(uv_l, K_l, dist_l)
    uv_r = cv.undistortPoints(uv_r, K_r, dist_r)

    num_obj = min(len(uv_l[0]), len(uv_r[0]))

    M = np.array(cv.triangulatePoints(P_l, P_r, uv_l, uv_r))

    for i in range(num_obj):
        M[:3,i] = M[:3,i] / M[3,i]

    rHw = np.identity(4)
    rHw[:3, 3] = [-385, 200, -320]
    M = np.matmul(rHw, M)

    # for xyz in M.transpose():
        # move gripper to xyz
        # syscall closeGripper
        # move gripper to tube
        # syscall openGripper

    time.sleep(1)
    print('server: completed')
    server.set_succeeded()


def load_calib():
    global P_l, K_l, dist_l, P_r, K_r, dist_r

    f = cv.FileStorage('calibration.xml', cv.FILE_STORAGE_READ)
    
    P_l = f.getNode('P_l').mat()
    K_l = f.getNode('K_l').mat()
    dist_l = f.getNode('dist_l').mat()
    
    P_r = f.getNode('P_r').mat()
    K_r = f.getNode('K_r').mat()
    dist_r = f.getNode('dist_r').mat()
    
    f.release()

###############################################################################

rospy.init_node('server')
server = actionlib.SimpleActionServer('puma', PumaAction, locate_objects, False)
server.start()
print('server: started')

load_calib()
print('server: calibration loaded')

rospy.spin()
