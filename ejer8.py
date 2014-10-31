nomFich = raw_input("Fichero: ")
#open files

cont=0
f = open(nomFich)
contA = contG = contC = contT = 0;
baseCodonNum = 0
baseCodon = ""
codones = []
for line in f:
	#processinng
	
	if(cont>4) :
		for base in line :	
			if(base == 'a') :
				contA+=1
				baseCodon += base
				baseCodonNum+=1
			elif (base == 'g') :
				contG+=1
				baseCodon += base
				baseCodonNum+=1
			elif (base == 'c') :
				contC+=1
				baseCodon += base
				baseCodonNum+=1
			elif (base == 't') :
				contT+=1
				baseCodon += base
				baseCodonNum+=1

			if baseCodonNum > 2 :
				baseCodonNum = 0
				codones.append(baseCodon)
				baseCodon = ""

	cont+=1

print codones
#closing files
f.close()

print "As: " + str(contA) + " Gs: " + str(contG) + " Cs: " + str(contC) + " Ts: " + str(contT)