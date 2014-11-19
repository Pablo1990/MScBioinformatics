while True :
	dna = raw_input("DNA:")
	contA=0
	contG=0
	contT=0
	contC=0
	for i in dna :
		if(i == 'A'):
			contA+=1
		elif (i == 'G'):
			contG+=1
		elif (i == 'T'):
			contT+=1
		elif (i == 'C'):
			contC+=1


	print "A: " + str(contA) + ". G: " + str(contG) + ". T: " + str(contT) + ". C: " + str(contC)