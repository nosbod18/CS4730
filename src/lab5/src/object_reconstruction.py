#!/usr/bin/env python

import cv2 as cv
import numpy as np


def find_uv(path):
    img = cv.imread(path)
    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

    _, thresh = cv.threshold(gray, 150, 255, cv.THRESH_BINARY_INV)

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

    return uv


def find_xyz(uv_l, uv_r, P_l, P_r):
    A = np.array([
        P_r[0, 0:3] - uv_r[0] * P_r[2, 0:3],
        P_r[1, 0:3] - uv_r[1] * P_r[2, 0:3],
        P_l[0, 0:3] - uv_l[0] * P_l[2, 0:3],
        P_l[1, 0:3] - uv_l[1] * P_l[2, 0:3]
    ])

    b = np.array([
        uv_r[0] * P_r[2, 3] - P_r[0, 3],
        uv_r[1] * P_r[2, 3] - P_r[1, 3],
        uv_l[0] * P_l[2, 3] - P_l[0, 3],
        uv_l[1] * P_l[2, 3] - P_l[1, 3]
    ])

    return np.matmul(np.linalg.pinv(A), b)


def load_calibration():
    f = cv.FileStorage('calibration.xml', cv.FILE_STORAGE_READ)

    P_l = f.getNode('P_l').mat()
    K_l = f.getNode('K_l').mat()
    P_r = f.getNode('P_r').mat()
    K_r = f.getNode('K_r').mat()

    f.release()

    return P_l, K_l, P_r, K_r


P_l, K_l, P_r, K_r, = load_calibration()

P_l = np.array([
    [-0.0022, 0.1432, -0.0117, 8.6098],
    [0.1395, 0.0060, -0.0218, 8.1640],
    [0, 0, -0.0001, 0.0676]
])

P_r = np.array([
    [-0.0021, 0.1307, -0.0527, 8.4486],
    [0.1367, -0.0022, -0.0226, 7.3504],
    [0, 0, -0.0001, 0.0702]
])

P_l = P_l * 10000
P_r = P_r * 1000

uv_l = find_uv('images/detection/left07.ppm')
uv_r = find_uv('images/detection/right07.ppm')

M = np.ones((4, len(uv_r)))

for i in range(len(uv_l)):
    M[:3, i] = find_xyz(uv_l[i], uv_r[i], P_l, P_r)
    M[ 1, i] = -M[1, i]

print(M)

rHw = np.array([
    [ 0, 1, 0,-389],
    [-1, 0, 0, 329],
    [ 0, 0, 1,-325],
    [ 0, 0, 0,   1]
])

M = np.matmul(rHw, M)
print(M)
