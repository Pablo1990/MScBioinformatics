#!/usr/bin/python
# -*- coding: utf-8 -*
# Made by Pablo Vicente Munuera
import re
import sys 

fi = open(sys.argv[1])

fi2=open(sys.argv[2])

for line in fi:
	fi2.seek(0)
	for line2 in fi2:
		if line.startswith(line2) or line2.startswith(line) :
			print line + line2
