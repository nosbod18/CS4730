#!/usr/bin/env python

import rospy
import actionlib
import time
from lab7.msg import PumaAction, PumaGoal


rospy.init_node('roomba')

client = actionlib.SimpleActionClient('puma', PumaAction)
print('roomba: client initialized, waiting for server...')
client.wait_for_server()

goal = PumaGoal()
goal.puma_id = 1

client.send_goal(goal)
print('roomba: request sent to puma #1, waiting for reply...')
client.wait_for_result()

print('roomba: object received')
print('roomba: driving...')
time.sleep(3)

goal.puma_id = 2

client.send_goal(goal)
print('roomba: request sent to puma #2, waiting for reply...')
client.wait_for_result()


print('roomba: object received')
