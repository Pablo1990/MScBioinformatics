import re

while True : 
	number = raw_input("Introduce your number: ")

	#
	if re.search('^[0-9]*(([\.][0-9]*([eE][+-]?[0-9]+)?)|([eE][+-]?[0-9]+))$', number) :
		print "It is!!!"
	else :
		print "It is not!"