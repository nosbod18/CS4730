#!/usr/bin/env python

import rospy
from std_msgs.msg import String
from geometry_msgs.msg import Twist

def move():
    # cmd_vel_mux/input/navi
    pub = rospy.Publisher('cmd_vel', Twist, queue_size=10)
    rospy.init_node('path_planner', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    
    r = .5

    cmd = Twist()
    cmd.angular.z = 0.3
    cmd.linear.x = cmd.angular.z * r

    while not rospy.is_shutdown():
        pub.publish(cmd)
        rate.sleep()

if __name__ == '__main__':
    try:
        move()
    except rospy.ROSInterruptException:
        pass
