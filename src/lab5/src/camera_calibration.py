#!/usr/bin/env python

import numpy as np
import cv2
import glob
import matplotlib.pyplot as plt

ROWS = 6
COLS = 8
CRITERIA = (cv2.TERM_CRITERIA_EPS + cv2.TERM_CRITERIA_MAX_ITER, 30, 0.001)

def calibrate(files):
    # Coordinates of checkerboard squares in world space
    objp = np.zeros((ROWS * COLS, 3), np.float32)
    objp[:, :2] = np.mgrid[0:ROWS, 0:COLS].T.reshape(-1, 2)
    objp = objp * 25 # Cell size is 25mm

    objpoints = []  # 3d point in real world space
    imgpoints = []  # 2d points in image plane

    images = [cv2.imread(f) for f in glob.glob(files)]

    h, w = images[0].shape[:2]

    for img in images:
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        ret, corners = cv2.findChessboardCorners(gray, (ROWS, COLS), None)

        if ret:
            corners = cv2.cornerSubPix(gray, corners, (11, 11), (-1, -1), CRITERIA)
            cv2.drawChessboardCorners(img, (ROWS, COLS), corners, ret)
            objpoints.append(objp)
            imgpoints.append(corners)

    return cv2.calibrateCamera(objpoints, imgpoints, (w, h), None, None)


def find_uv(path):
    img = cv2.imread(path)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    _, thresh = cv2.threshold(gray, 200, 255, cv2.THRESH_BINARY_INV)

    # Fill holes in image
    thresh2 = thresh.copy()
    h, w = thresh.shape[:2]
    mask = np.zeros((h + 2, w + 2), np.uint8)
    cv2.floodFill(thresh2, mask, (0, 0), 255)
    filled_inv = cv2.bitwise_not(thresh2)
    filled = thresh | filled_inv

    _, contours, hierarchy = cv2.findContours(filled, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

    # cv2.imshow('thresh', thresh)
    # cv2.imshow('filled', filled)

    uv = []

    for c in contours:
        M = cv2.moments(c)
        u = int(M["m10"] / M["m00"]) if M["m00"] != 0 else 0
        v = int(M["m01"] / M["m00"]) if M["m00"] != 0 else 0
        uv.append((u, v))
        cv2.circle(img, (u, v), 5, (0, 0, 255), -1)

    cv2.imshow('centroids', img)

    return np.array(uv)


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


def find_objects(path_l, path_r, K_l, K_r, R_l, R_r, T_l, T_r):
    uv_l = find_uv(path_l)
    uv_r = find_uv(path_r)

    RT_l = np.array([
        [R_l[0][0], R_l[0][1], R_l[0][2], T_l[0][0]],
        [R_l[1][0], R_l[1][1], R_l[1][2], T_l[1][0]],
        [R_l[2][0], R_l[2][1], R_l[2][2], T_l[1][0]]
    ])

    RT_r = np.array([
        [R_r[0][0], R_r[0][1], R_r[0][2], T_r[0][0]],
        [R_r[1][0], R_r[1][1], R_r[1][2], T_r[1][0]],
        [R_r[2][0], R_r[2][1], R_r[2][2], T_r[2][0]]
    ])

    P_l = np.matmul(K_l, RT_l)
    P_r = np.matmul(K_r, RT_r)

    num_obj = min(len(uv_l), len(uv_r))

    M = np.ones((4, num_obj), np.float32)

    for i in range(num_obj):
        M[0:3, i] = find_xyz(uv_l[i], uv_r[i], P_l, P_r)

    return M


if __name__ == '__main__':
    rmse_l, K_l, dist_l, rvecs_l, tvecs_l = calibrate('images/calibration/left/*')
    rmse_r, K_r, dist_r, rvecs_r, tvecs_r = calibrate('images/calibration/right/*')

    R_l, _ = cv2.Rodrigues(rvecs_l[0])
    R_r, _ = cv2.Rodrigues(rvecs_r[0])
    T_l = tvecs_l[0]
    T_r = tvecs_r[0]

    # x: 385mm
    # y: 100mm
    # z: 320mm


    M = find_objects('images/detection/left/02.ppm', 'images/detection/right/02.ppm', K_l, K_r, R_l, R_r, T_l, T_r)

    rHw = np.identity(4)
    rHw[0:3, 3] = [385, 100, 320]
    M = np.matmul(rHw, M)

    print(M)

    cv2.waitKey(0)