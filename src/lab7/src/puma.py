#!/usr/bin/env python

import rospy
import cv2 as cv
import numpy as np
import actionlib
import time
import os
import subprocess
from lab7.msg import PumaAction, PumaGoal


PUMA_ID = 1
server = None

def callback():
    print('server: executing matlab...')
    os.system('matlab -nodisplay -nosplash -nodesktop -r \'move_objects; exit\' > /dev/null')

callback()

#rospy.init_node('puma')
#server = actionlib.SimpleActionServer('puma', PumaAction, callback, False)
#server.start()
#print('server: started')
#
#rospy.spin()


# IDEAS:
# - If an object is detected that's larger than the area of the biggest single object, grab the box
#   and shake it to move the objects around. If there's still an object that's larger, do it again.
# - Once an object is picked up, move the arm to a few positions in the right direction do it doesn't
#   hit the cameras
