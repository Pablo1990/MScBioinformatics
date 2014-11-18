#Regular expression import
import re

while True :
	var = raw_input("Variable: ")
	if(re.match('^\$[a-zA-Z][a-zA-Z0-9_]*$', var)) :
		print "Yes"
	else :
		print "No"