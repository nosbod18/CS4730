#!/usr/bin/env python

import rospy
import cv2 as cv
import numpy as np
import actionlib
import time
import subprocess
from lab7.msg import PumaAction, PumaGoal

PUMA_ID = 1


##### Inverse kinematics ######################################################

# theta, d, a, alpha
DH = np.array([
    [0,      0, 0, -90],
    [0, 4.9375, 8,   0],
    [0,      0, 0,  90],
    [0,      8, 0, -90],
    [0,      0, 0,  90],
    [0,  2.202, 0,   0]
])

DH[:,1:3] = DH[:,1:3] * 25.4
DH[:,-1] = np.deg2rad(DH[:,-1])
# DH[:,0] = np.deg2rad(DH[:,0])


def T_end_effector(xyz, oat):
    x, y, z = xyz # mm
    o, a, t = oat # rad

    s_a, s_o, s_t = np.sin(a), np.sin(o), np.sin(t)
    c_a, c_o, c_t = np.cos(a), np.cos(o), np.cos(t)

    return np.array([
        [-s_o * s_a * c_t + c_o * s_t,  s_o * s_a * s_t + c_o * c_t,  s_o * c_a, x],
        [ c_o * s_a * c_t + s_o * s_t, -c_o * s_a * s_t + s_o * c_t, -c_o * c_a, y],
        [-c_a * c_t,                    c_a * s_t,                   -s_a,       z],
        [0,                             0,                            0,         1]
    ])


def A_joint(i, t):
    return np.array([
            [np.cos(t), -np.sin(t) * np.cos(DH[i, 3]),  np.sin(t) * np.sin(DH[i, 3]), DH[i, 2] * np.cos(t)],
            [np.sin(t),  np.cos(t) * np.cos(DH[i, 3]), -np.cos(t) * np.sin(DH[i, 3]), DH[i, 2] * np.sin(t)],
            [0,          np.sin(DH[i, 3]),              np.cos(DH[i, 3]),             DH[i, 1]],
            [0,          0,                             0,                            1]
    ])


def calc_t_1(px, py, pz):
    d_2 = DH[1, 1]
    sqrt = np.sqrt(px ** 2 + py ** 2 - d_2 ** 2)
    return np.arctan2(py * sqrt - d_2 * px,
                      px * sqrt + d_2 * py)


def calc_t_2(px, py, pz, t_3):
    d_2 = DH[1, 1]
    d_4 = DH[3, 1]
    a_2 = DH[1, 2]


##### Camera calibration ######################################################

P_l = None
K_l = None
dist_l = None

P_r = None
K_r = None
dist_r = None

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

    print('puma:  goal recieved, executing script...')

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

    for (x, y, z) in M.transpose():
        subprocess.call(['PumaMoveXYZOAT', '{}'.format(x), '{}'.format(y), '{}'.format(z), '')
        # move gripper to xyz
        # syscall closeGripper
        # move gripper to tube
        # syscall openGripper

    time.sleep(1)
    print('puma:  completed')
    puma.set_succeeded()


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


##### Action server ###########################################################

server = None


rospy.init_node('puma')
server = actionlib.SimpleActionServer('puma', PumaAction, locate_objects, False)
server.start()
print('puma:  started')

load_calib()
print('puma:  calibration loaded')

rospy.spin()
