#!/usr/bin/env python

import rospy
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist, Quaternion
import tf
import numpy as np
import sys
import math

# Some ideas:
# - Clamp the velocities to avoid large jumps between positive and negative near the target position
# - Fusing the imu data with the odometry data (maybe an existing ros package)


class Transforms():
    def __init__(self):
        self.H_initial_to_current = np.identity(4)
        self.H_current_to_initial = np.identity(4)
        self.H_current_to_goal = np.identity(4)
        self.H_initial_to_goal = np.identity(4)

        # The difference between alpha and beta affects the movement speed of the robot (big difference == faster)
        # Beta affects how far the robot deviates from the path to make it to the final location
        # i.e. the closer beta is to 0, the straighter the path will be
        K_rho = 1       # 1
        K_alpha = 4     # 2
        K_beta = -0.5   # -.3
        self.gain = [K_rho, K_alpha, K_beta]

        self.rho = 0
        self.alpha = 0
        self.beta = 0
        self.v = 0
        self.w = 0

        self.odom_received = False
        self.imu_received = False
        self.first_imu = True
        self.imu_bias = 0

        self.threshold_linear = 0.05
        self.threshold_angular = 0.1 # 0.2

        self.position_current = None
        self.RPY_current = [0, 0, 0]

        self.error = [0, 0, 0]


    def cartesian_to_polar(self):
        # Extract current x, y, and theta
        x = self.H_current_to_goal[0, 3]
        y = self.H_current_to_goal[1, 3]
        theta = tf.transformations.euler_from_matrix(self.H_current_to_goal[:3,:3], 'rxyz')[2]
        pose = (x, y, theta)
        
        self.rho = np.sqrt(pose[0]**2 + pose[1]**2)
        self.alpha = math.atan2(-pose[1], -pose[0]) - pose[2]
        self.alpha = self.alpha % (2*math.pi)

        if (self.alpha > math.pi):
            self.alpha -= 2*math.pi
        self.beta = -self.alpha - pose[2] 


    def initialize_goal(self, x, y, theta):
        self.H_initial_to_goal = np.array([[np.cos(theta),-np.sin(theta), 0, x],
                                           [np.sin(theta), np.cos(theta), 0, y],
                                           [0,             0,             1, 0],
                                           [0,             0,             0, 1]])

    def get_vw(self):
        self.v = self.gain[0] * self.rho
        self.w = (self.gain[1] * self.alpha) + (self.gain[2] * self.beta)

    def odom_callback(self, data):
        self.position_current = data.pose.pose.position
        q = data.pose.pose.orientation
        # print('odom ', math.degrees(tf.transformations.euler_from_quaternion([q.x, q.y, q.z, q.w])[2]))
        self.odom_received = True

    def imu_callback(self, data):
        orientation = [data.x, data.y, data.z, data.w]
        self.RPY_current = list(tf.transformations.euler_from_quaternion(orientation))

        if self.first_imu == True:
            self.imu_bias = self.RPY_current[2]
            self.first_imu = False

        self.RPY_current[2] -= self.imu_bias
        print('imu RPY (degrees): {}, {}, {}'.format(math.degrees(self.RPY_current[0]), math.degrees(self.RPY_current[1]), math.degrees(self.RPY_current[2])))
        self.imu_received = True

    def update_current(self):
        self.H_initial_to_current = np.array([[np.cos(self.RPY_current[2]), -np.sin(self.RPY_current[2]), 0, self.position_current.x],
                                              [np.sin(self.RPY_current[2]),  np.cos(self.RPY_current[2]), 0, self.position_current.y],
                                              [0,                            0,                           1, self.position_current.z],
                                              [0,                            0,                           0, 1]])
        self.H_current_to_goal = np.matmul(tf.transformations.inverse_matrix(self.H_initial_to_goal), self.H_initial_to_current)

        self.imu_received = False
        self.odom_received = False


    def move(self):
        rospy.init_node('odom_subscriber', anonymous=True)

        rospy.Subscriber('/odom', Odometry, self.odom_callback)
        rospy.Subscriber('/imu', Quaternion, self.imu_callback)
        pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)
        rate = rospy.Rate(10)

        x_G = 1     # 0.8
        y_G = 0
        theta_G = 90
        theta_G = math.radians(theta_G)
        self.initialize_goal(x_G, y_G, theta_G)

        while not rospy.is_shutdown():
            if self.odom_received and self.imu_received:
                self.update_current()

                # H_current_to_initial = tf.transformations.inverse_matrix(self.H_initial_to_current)
                # print('ic')
                # print(self.H_initial_to_current)
                # print('cg')
                # print(self.H_current_to_goal)

                # Convert to polar coordinates
                self.cartesian_to_polar()
                self.get_vw()

                # print(self.v, self.w)

                move = Twist()
                move.linear.x = self.v
                move.angular.z = self.w
                # pub.publish(move)

                # print(abs(x_G - self.position_current[0]) <= self.threshold_linear, abs(y_G - self.pose_current[1]) <= self.threshold_linear, abs(theta_G - self.pose_current[2]) <= self.threshold_angular)
                compared_angle = theta_G - self.RPY_current[2]
                compared_angle = (compared_angle+np.pi)%(2*np.pi) - np.pi

                if abs(x_G - self.position_current.x) <= self.threshold_linear and abs(y_G - self.position_current.y) <= self.threshold_linear and abs(compared_angle) <= self.threshold_angular:
                    self.error = [abs(x_G - self.position_current.x), abs(y_G - self.position_current.y), abs(compared_angle)]
                    
                    stop = Twist()
                    stop.linear.x = 0
                    stop.angular.z = 0

                    pub.publish(stop)
                    break
               
            rate.sleep()
            

if __name__ == '__main__':
    transforms = Transforms()
    transforms.move()
