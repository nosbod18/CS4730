#!/usr/bin/env python

import rospy
import actionlib
import time
from lab7.msg import PumaAction, PumaGoal


rospy.init_node('client')

client = actionlib.SimpleActionClient('puma', PumaAction)
print('client: client initialized, waiting for server...')
client.wait_for_server()

goal = PumaGoal()
goal.puma_id = 1

client.send_goal(goal)
print('client: request sent to puma #1, waiting for reply...')
client.wait_for_result()

print('client: object received')
print('client: driving...')
time.sleep(3)

goal.puma_id = 2

client.send_goal(goal)
print('client: request sent to puma #2, waiting for reply...')
client.wait_for_result()


print('client: object received')
