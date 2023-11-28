#!/usr/bin/env python

import numpy as np

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
    a_3 = DH[2, 2]
    s_3 = np.sin(t_3)
    c_3 = np.cos(t_3)

    sqrt = np.sqrt(px ** 2 + py ** 2 - d_2 ** 2)
    h = d_4 * c_3 - a_3 * s_3       # temporary variable, name doesn't mean anything
    g = a_2 + a_3 * c_3 + d_4 * s_3 # temporary variable, name doesn't mean anything

    return np.arctan2( pz * g + h * sqrt,
                     -(pz * h - g * sqrt))


def calc_t_3(px, py, pz):
    d_2 = DH[1, 1]
    d_4 = DH[3, 1]
    a_2 = DH[1, 2]
    a_3 = DH[2, 2]

    r2 = 4 * a_2 ** 2 * (a_3 ** 2 + d_4 ** 2)
    R = px ** 2 + py ** 2 + pz ** 2 - a_2 ** 2 - a_3 ** 2 - d_2 ** 2 - d_4 ** 2
    sqrt = np.sqrt(r2 - R ** 2)

    return np.arctan2(2 * a_2 * d_4 * R    - 2 * a_2 * a_3 * sqrt,
                      2 * a_2 * d_4 * sqrt + 2 * a_2 * a_3 * R)


def calc_t_4(T3_6):
    return np.arctan2(T3_6[1, 2],
                      T3_6[0, 2])


def calc_t_5(T3_6, t_4):
    return np.arctan2(T3_6[0, 2] * np.cos(t_4) + T3_6[1, 2] * np.sin(t_4),
                      T3_6[2, 2])


def calc_t_6(T3_6):
    return np.arctan2(T3_6[2, 1],
                     -T3_6[2, 0])


def ik(xyz, oat):
    T0_6 = T_end_effector(xyz, oat)

    P4_6 = DH[5, 1] * T0_6[0:3, 2]
    P0_4 = xyz - P4_6
    px, py, pz = P0_4

    t_1 = calc_t_1(px, py, pz)
    t_3 = calc_t_3(px, py, pz)
    t_2 = calc_t_2(px, py, pz, t_3)

    A_1 = A_joint(0, t_1)
    A_2 = A_joint(1, t_2)
    A_3 = A_joint(2, t_3)

    T0_3 = np.matmul(A_1, np.matmul(A_2, A_3))
    T3_6 = np.matmul(np.linalg.inv(T0_3), T0_6)

    t_4 = calc_t_4(T3_6)
    t_5 = calc_t_5(T3_6, t_4)
    t_6 = calc_t_6(T3_6)

    return list(np.rad2deg([t_1, t_2, t_3, t_4, t_5, t_6]))


if __name__ == '__main__':
    # xyz = [393.686, 165.908, 206.408]
    # oat = [86.135, -23.828, 16.023]
    xyz = [393.6866, 165.9105, -161.2123]
    oat = [86.1348, -23.8289, 15.024]

    print('   X         Y         Z         O         A         T')
    print('{:.3f}    {:.3f}    {:.3f}    {:.3f}    {:.3f}    {:.3f}\n'.format(xyz[0], xyz[1], xyz[2], oat[0], oat[1], oat[2]))


    thetas = ik(xyz, np.deg2rad(oat))
    print('Jt 1      Jt 2      Jt 3      Jt 4      Jt 5      Jt 6')
    print('{:.3f}    {:.3f}    {:.3f}    {:.3f}    {:.3f}    {:.3f}'.format(thetas[0], thetas[1], thetas[2], thetas[3], thetas[4], thetas[5]))
