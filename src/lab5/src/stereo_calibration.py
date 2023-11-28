#!/usr/bin/env python

import cv2 as cv
import numpy as np
import glob

ROWS = 6
COLS = 8
SQUARE_SIZE = 25 # mm
CRITERIA = (cv.TERM_CRITERIA_EPS + cv.TERM_CRITERIA_MAX_ITER, 100, 0.0001)


def calibrate():
    imgs_l = [cv.imread(f) for f in glob.glob('images/calibration/left/*')]
    imgs_r = [cv.imread(f) for f in glob.glob('images/calibration/right/*')]
 
    # coordinates of squares in the checkerboard world space
    objp = np.zeros((ROWS * COLS, 3), np.float32)
    objp[:, :2] = np.mgrid[0:ROWS, 0:COLS].T.reshape(-1, 2)
    objp = SQUARE_SIZE * objp
 
    #Pixel coordinates of checkerboards
    imgpoints_l = [] # 2d points in image plane.
    imgpoints_r = []
 
    #coordinates of the checkerboard in checkerboard world space.
    objpoints = [] # 3d point in real world space

    h, w = imgs_l[0].shape[:2]
 
    for img_l, img_r in zip(imgs_l, imgs_r):
        gray_l = cv.cvtColor(img_l, cv.COLOR_BGR2GRAY)
        gray_r = cv.cvtColor(img_r, cv.COLOR_BGR2GRAY)
        c_ret1, corners_l = cv.findChessboardCorners(gray_l, (ROWS, COLS), None)
        c_ret2, corners_r = cv.findChessboardCorners(gray_r, (ROWS, COLS), None)
 
        if c_ret1 == True and c_ret2 == True:
            corners_l = cv.cornerSubPix(gray_l, corners_l, (11, 11), (-1, -1), CRITERIA)
            imgpoints_l.append(corners_l)
 
            corners_r = cv.cornerSubPix(gray_r, corners_r, (11, 11), (-1, -1), CRITERIA)
            imgpoints_r.append(corners_r)
 
            objpoints.append(objp)

    rsme_l, K_l, dist_l, rvecs_l, tvecs_l = cv.calibrateCamera(objpoints, imgpoints_l, (w, h), None, None)
    rsme_r, K_r, dist_r, rvecs_r, tvecs_r = cv.calibrateCamera(objpoints, imgpoints_r, (w, h), None, None)

    rsme_s, K_l, dist_l, K_r, dist_r, R_s, T_s, E, F = cv.stereoCalibrate(objpoints, imgpoints_l, imgpoints_r, K_l, dist_l, K_r, dist_r, (w, h), criteria=CRITERIA)

    R_l = cv.Rodrigues(rvecs_l[0])[0]
    t_l = tvecs_l[0]
    Rt_l = np.concatenate([R_l, t_l], axis=-1)
    P_l = np.matmul(K_l, Rt_l)

    R_r = cv.Rodrigues(rvecs_r[0])[0]
    t_r = tvecs_r[0]
    Rt_r = np.concatenate([R_r, t_r], axis=-1)
    P_r = np.matmul(K_r, Rt_r)

    return K_l, K_r, P_l, P_r, dist_l, dist_r


def find_uv(path):
    img = cv.imread(path)
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

    cv.imshow('thresh', thresh)
    cv.imshow('filled', filled)

    uv = []

    for c in contours:
        M = cv.moments(c)
        u = int(M["m10"] / M["m00"]) if M["m00"] != 0 else 0
        v = int(M["m01"] / M["m00"]) if M["m00"] != 0 else 0
        uv.append([u, v])
        cv.circle(img, (u, v), 5, (0, 0, 255), -1)

    cv.imshow('img', img)

    cv.waitKey(0)

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


if __name__ == '__main__':
    K_l, K_r, P_l, P_r, dist_l, dist_r = calibrate()

    uv_l = find_uv('images/detection/left/04.ppm')
    uv_r = find_uv('images/detection/right/04.ppm')

    uv_l = cv.undistortPoints(uv_l, K_l, dist_l)
    uv_r = cv.undistortPoints(uv_r, K_r, dist_r)

    print(uv_l)
    print(uv_r)

    num_obj = min(len(uv_l[0]), len(uv_r[0]))

    M = np.array(cv.triangulatePoints(P_l, P_r, uv_l, uv_r))

    for i in range(num_obj):
        M[:3,i] = M[:3,i] / M[3,i]

    rHw = np.identity(4)
    rHw[:3, 3] = [-385, 200, -320]
    M = np.matmul(rHw, M)

    print(M)
