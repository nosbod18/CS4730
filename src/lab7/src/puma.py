#!/usr/bin/env python

import rospy
import cv2 as cv
import numpy as np
import actionlib
import time
import os
import subprocess
#from lab7.msg import PumaAction, PumaGoal


##### Object Reconstruction ###################################################

def transport_objects():
    pass

        #x, y, z, o, a, t = 0, 0, -66, 0, 90, 0

        #with open('results.txt', 'r') as f:
        #    if nobj == -1:
        #        nobj = int(f.readline())
        #    else:
        #        f.readline()

        #    xyt = f.readline().split()
        #    x, y, t = float(xyt[0]), float(xyt[1]), (90 - float(xyt[2]))
        #    nobj -= 1

        #print(x, y, t)

        ## if x > {}: a =  45, x -= 35
        ## if x < {}: a = -45, x += 26

        ## Move to object and grab it
        #os.system('PumaMoveXYZOAT {} {} -66 0 90 {} > /dev/null'.format(x, y, t))
        #print('1')
        #os.system('openGripper')
        #print('2')
        #os.system('PumaMoveXYZOAT {} {} -184 0 90 {} > /dev/null'.format(x, y, t))
        #print('3')
        #os.system('closeGripper')
        #print('4')

        ## Move up and over to be clear of the camera stand
        #os.system('PumaMoveXYZOAT {} {} -66 0 90 {} > /dev/null'.format(x, y, t))
        #print('5')
        #os.system('PumaMoveXYZOAT 126 282 -66 0 90 0 > /dev/null')
        #print('6')

        ## Flip over and drop object
        #os.system('PumaMoveJoints -90 -90 90 0 0 0 > /dev/null')
        #print('7')
        #os.system('Puma_SPEED 20')
        #print('7.5')
        #os.system('PumaMoveJoints 90 -90 90 0 0 0 > /dev/null')
        #print('8')
        #os.system('Puma_SPEED 10')
        #print('8.5')
        #os.system('PumaMoveXYZOAT -115 -400 -135 0 0 180 > /dev/null')
        #print('9')
        #os.system('openGripper')
        #print('10')
        #os.system('closeGripper')
        #print('11')

        ## Flip over
        #os.system('PumaMoveJoints 90 -90 90 0 0 0 > /dev/null')
        #print('12')
        #os.system('PumaMoveJoints -90 -90 90 0 0 0 > /dev/null')
        #print('13')
        #os.system('PumaMoveXYZOAT 126 282 -66 0 90 0 > /dev/null')
        #print('14')

    #puma.set_succeeded()
    #os.system('PumaMoveXYZOAT 245.083 -177.876 -66.469 0.720 -0.014 -106.168 > /dev/null') # do ready


##### Action server ###########################################################

os.system('matlab -nodisplay -nosplash -nodesktop -r \'move_objects; exit\' > /dev/null')

#PUMA_ID = 1
#
#server = None
#
#rospy.init_node('puma')
#server = actionlib.SimpleActionServer('puma', PumaAction, locate_objects, False)
#server.start()
#print('puma:  started')
#
#load_calib()
#print('puma:  calibration loaded')
#
#rospy.spin()


# IDEAS:
# - If an object is detected that's larger than the area of the biggest single object, grab the box
#   and shake it to move the objects around. If there's still an object that's larger, do it again.
# - Once an object is picked up, move the arm to a few positions in the right direction do it doesn't
#   hit the cameras
# -
