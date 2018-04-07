#!/usr/bin/env python

import serial
import os


if ( os.getuid() != 0 ):
	print "You must run the script as root to be able to read from `/dev/ttyACM0`!"
	exit()


ser = serial.Serial('/dev/ttyACM0')

while True:
	print ser.readline().strip()
