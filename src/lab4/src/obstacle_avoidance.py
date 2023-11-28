#!/usr/bin/env python
import rospy
from ca_msgs.msg import Bumper
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist, Quaternion
import tf
import numpy as np
import sys
import math

left_contact = False
right_contact = False

def bumper_callback(data):
    global left_contact, right_contact
    right_contact = data.is_right_pressed
    left_contact = data.is_left_pressed

def loop():
    rospy.init_node('obstacle_avoidance', anonymous=True)

    sub = rospy.Subscriber('/bumper', Bumper, bumper_callback)
    pub = rospy.Publisher('/cmd_vel', Twist, queue_size=1)
    rate = rospy.Rate(10)

    turn = Twist()

    while not rospy.is_shutdown():
        if left_contact is True:
            turn.angular.z = -1
            pub.publish(turn)

        if right_contact is True:
            turn.angular.z = 1
            pub.publish(turn)



if __name__ == '__main__':
    loop()



