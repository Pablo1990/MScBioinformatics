#!/usr/bin/python
# -*- coding: utf-8 -*
# Made by Pablo Vicente Munuera
import re
import sys

nameFi = sys.argv[1]

fi=open(nameFi)

fileName = nameFi.split('/')

o=open("sondas"+ fileName[len(fileName)-1] + ".txt","w")


lines={}

for line in fi:
	if (line.startswith("@attribute") or line.startswith("@ATTRIBUTE")) :
		words = line.split(' ')
		so = words[1].split("_")
		if len(so)>3 :
			o.write(words[1][:-2]+'\n')
		else:
			o.write(words[1]+'\n')

o.close()

fi = open("GPL6480_Annotation.txt")

fi2 = open("sondas"+ fileName[len(fileName)-1] + ".txt")

of =open("genes/"+ nameFi + ".txt","w")

for sondas in fi2:
	fi.seek(646)
	for lines in fi:
		words = lines.split("\t")
		if (words[1]==sondas[:-1]) :
			if(words[6]!=''):
				of.write(words[6] + '\n')
			else:
				of.write('Unknown\n')
			break

of.close()
