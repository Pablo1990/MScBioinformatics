#!/usr/bin/python
# -*- coding: utf-8 -*
# Made by Jose Alejandro Romero Herrera
import re
f=open("final.arff")
o=open("final2.arff","a")
lines={}
for line in f:
  if lines.has_key(line):
    lines[line]+=1
    line_duplicate = line.split(" ")
    line_duplicate = line_duplicate[0]+" "+line_duplicate[1]+"_"+str(lines[line])+" "+line_duplicate[2]
    o.write(line_duplicate)
  else :
    lines[line]=1
    o.write(line)
