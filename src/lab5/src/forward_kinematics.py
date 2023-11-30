#!/usr/bin/env python

import numpy as np

t = [7.147, 31.486, 80.989, -166.296, 47.525, -178.822]
d = [0, 4.93755, 0, 8, 0, 2.202]

DH = np.array([
    [t[0], d[0],  0, -90],
    [t[1], d[1],  8,   0],
    [t[2], d[2],  0,  90],
    [t[3], d[3],  0, -90],
    [t[4], d[4],  0,  90],
    [t[5], d[5],  0,   0]
])

DH[:,1:3] = DH[:,1:3] * 25.4
DH[:,-1] = np.deg2rad(DH[:,-1])
DH[:,0] = np.deg2rad(DH[:,0])


def H_joint_i(i):
    return np.array([
            [np.cos(DH[i, 0]), -np.sin(DH[i, 0]) * np.cos(DH[i, 3]),  np.sin(DH[i, 0]) * np.sin(DH[i, 3]), DH[i, 2] * np.cos(DH[i, 0])],
            [np.sin(DH[i, 0]),  np.cos(DH[i, 0]) * np.cos(DH[i, 3]), -np.cos(DH[i, 0]) * np.sin(DH[i, 3]), DH[i, 2] * np.sin(DH[i, 0])],
            [0,                 np.sin(DH[i, 3]),                     np.cos(DH[i, 3]),                    DH[i, 1]],
            [0,                 0,                                    0,                                   1]
    ])


def H_end_effector(joints):
    H = np.identity(4)
    for A in joints:
        H = np.matmul(H, A)
    return H


if __name__ == '__main__':
    joints = [
        H_joint_i(0),
        H_joint_i(1),
        H_joint_i(2),
        H_joint_i(3),
        H_joint_i(4),
        H_joint_i(5),
    ]

    H = H_end_effector(joints)

    # Calculate OAT
    R = H[0:3, 0:3]
    oat = [0, 0, 0]
    oat[0] = np.arctan2(R[0, 2], -R[1, 2])
    oat[2] = np.arctan2(R[2, 1], -R[2, 0])
    oat[1] = np.arctan2(-np.cos(oat[2]) * R[2, 2], -R[2, 0])
    oat = np.rad2deg(oat)

    # Extract XYZ
    xyz = H[0:3, 3]

    print('joint configuration = ', t)
    print('xyz = [{}, {}, {}]'.format(xyz[0], xyz[1], xyz[2]))
    print('oat = [{}, {}, {}]'.format(oat[0], oat[1], oat[2]))


# minicom -D /dev/ttyUSB0 -b 9600
