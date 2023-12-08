#!/usr/bin/env python

import cv2 as cv
import numpy as np
import glob

ROWS = 6
COLS = 8
SQUARE_SIZE = 25 # mm
CRITERIA = (cv.TERM_CRITERIA_EPS + cv.TERM_CRITERIA_MAX_ITER, 30, 0.001)

imgs_l = [cv.imread(f) for f in glob.glob('images/calibration/left*')]
imgs_r = [cv.imread(f) for f in glob.glob('images/calibration/right*')]

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
    ret_l, corners_l = cv.findChessboardCorners(gray_l, (ROWS, COLS), None)
    ret_r, corners_r = cv.findChessboardCorners(gray_r, (ROWS, COLS), None)

    if ret_l == True and ret_r == True:
        corners_l = cv.cornerSubPix(gray_l, corners_l, (9, 9), (-1, -1), CRITERIA)
        imgpoints_l.append(corners_l)

        corners_r = cv.cornerSubPix(gray_r, corners_r, (9, 9), (-1, -1), CRITERIA)
        imgpoints_r.append(corners_r)

        objpoints.append(objp)

rsme_l, K_l, dist_l, rvecs_l, tvecs_l = cv.calibrateCamera(objpoints, imgpoints_l, (w, h), None, None)
rsme_r, K_r, dist_r, rvecs_r, tvecs_r = cv.calibrateCamera(objpoints, imgpoints_r, (w, h), None, None)

R_l = cv.Rodrigues(rvecs_l[0])[0]
t_l = tvecs_l[0]
Rt_l = np.concatenate([R_l, t_l], axis=-1)
P_l = np.matmul(K_l, Rt_l)

print('K_l: {}\n'.format(K_l))
print('R_l: {}\n'.format(R_l))
print('t_l: {}\n'.format(t_l))
print('P_l: {}\n'.format(P_l))

R_r = cv.Rodrigues(rvecs_r[0])[0]
t_r = tvecs_r[0]
Rt_r = np.concatenate([R_r, t_r], axis=-1)
P_r = np.matmul(K_r, Rt_r)

print('K_r: {}\n'.format(K_r))
print('R_r: {}\n'.format(R_r))
print('t_r: {}\n'.format(t_r))
print('P_r: {}\n'.format(P_r))

f = cv.FileStorage('calibration.xml', cv.FILE_STORAGE_WRITE)
f.write('K_l', K_l)
f.write('P_l', P_l)
f.write('K_r', K_r)
f.write('P_r', P_r)

f.release()

