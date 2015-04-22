#!/usr/bin/python
# -*- coding: utf-8 -*
# Made by Pablo Vicente Munuera
import re
import sys

nameFi = sys.argv[1]

fi=open(nameFi)

fileName = nameFi.split('/')

o=open("sondas"+ fileName[len(fileName)-1] + ".txt","a")


lines={}

for line in fi:
	if (line.startswith("@attribute") or line.startswith("@ATTRIBUTE")) :
		words = line.split(' ')
		o.write(words[1] + '\n')

o.close()