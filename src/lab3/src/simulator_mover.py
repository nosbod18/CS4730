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
        K_rho = 10       # 1
        K_alpha = 11     # 2
        K_beta = -0.3   # -.3
        self.gain = [K_rho, K_alpha, K_beta]

        self.rho = 0
        self.alpha = 0
        self.beta = 0
        self.v = 0
        self.w = 0

        self.odom_received = False

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
        orientation = data.pose.pose.orientation 
        orientation = [orientation.x, orientation.y, orientation.z, orientation.w]
        self.RPY_current = list(tf.transformations.euler_from_quaternion(orientation))
        
        self.odom_received = True

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
        # rospy.Subscriber('/imu', Quaternion, self.imu_callback)
        pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)
        rate = rospy.Rate(10)

        x_G = 2     # 0.8
        y_G = -1
        theta_G = 0
        theta_G = math.radians(theta_G)
        self.initialize_goal(x_G, y_G, theta_G)

        while not rospy.is_shutdown():
            if self.odom_received:
                self.update_current()

                # Convert to polar coordinates
                self.cartesian_to_polar()
                self.get_vw()

                move = Twist()
                move.linear.x = self.v
                move.angular.z = self.w
                pub.publish(move)

                compared_angle = theta_G - self.RPY_current[2]
                compared_angle = (compared_angle+np.pi)%(2*np.pi) - np.pi

                if abs(x_G - self.position_current.x) <= self.threshold_linear and abs(y_G - self.position_current.y) <= self.threshold_linear and abs(compared_angle) <= self.threshold_angular:
                    self.error = [abs(x_G - self.position_current.x), abs(y_G - self.position_current.y), abs(compared_angle)]
                    
                    stop = Twist()
                    stop.linear.x = 0
                    stop.angular.z = 0

                    pub.publish(stop)
                    print(self.error)
                    break
               
            rate.sleep()
            
            

if __name__ == '__main__':
    transforms = Transforms()
    transforms.move()
