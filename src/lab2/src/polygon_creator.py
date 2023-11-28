#!/usr/bin/env python

import rospy
import math
from std_msgs.msg import String
from geometry_msgs.msg import Twist

def turn(pub, amount):
    t0 = rospy.Time.now().to_sec()
    theta = 0
    w = 0.5

    cmd = Twist()
    cmd.angular.z = w

    while theta < amount:
        pub.publish(cmd)
        dt = rospy.Time.now().to_sec() - t0
        theta = w * dt


def move(pub, amount):
    t0 = rospy.Time.now().to_sec()
    d = 0
    v = 0.5

    cmd = Twist()
    cmd.linear.x = v

    while d < amount:
        pub.publish(cmd)
        dt = rospy.Time.now().to_sec() - t0
        d = v * dt


def loop():
    # cmd_vel_mux/input/navi
    pub = rospy.Publisher('cmd_vel', Twist, queue_size=1)
    rospy.init_node('polygon_creator', anonymous=True)

    stop = Twist()
    stop.linear.x = 0
    stop.angular.z = 0

    move_amt = 1
    turn_amt = math.pi / 2
    moved = 0

    while not rospy.is_shutdown():
        if pub.get_num_connections() == 0:
            continue

        if moved == 0:
            move(pub, move_amt)
            turn(pub, turn_amt)
            move(pub, move_amt)
            turn(pub, turn_amt)
            move(pub, move_amt)
            turn(pub, turn_amt)
            move(pub, move_amt)
            turn(pub, turn_amt)
            moved = 1

        pub.publish(stop)
        break


if __name__ == '__main__':
    try:
        loop()
    except rospy.ROSInterruptException:
        pass
