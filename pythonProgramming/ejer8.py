def printAADependsOnPer(totalAminoAcids, aminoAcids) :
	percentage=input("Percentage: ")
	for aa in aminoAcids.items():
		perActual=aa[1]/float(totalAminoAcids)*100
		if(perActual >= percentage) :
			print "Name: " + aa[0] + "\t\tPercentage: " + str(perActual) + " %"

# ---------------------------------------------------------------------------- #

#dictionary key=codon - value=aminoacid
tabla={"ctt":"Leucine","atg":"Methionine","aca":"thronine","acg":"thronine","atc":"Isoleucine","aac":"Asparagine",
"ata":"Isoleucine","agg":"Arginine","cct":"Proline","act":"thronine","agc":"Serine","aag":"Lysine","aga":"Arginine",
"cat":"Histidine","aat":"Asparagine","att":"Isoleucine","ctg":"Leucine","cta":"Leucine","ctc":"Leucine","cac":"Histidine",
"aaa":"Lysine","ccg":"Proline","agt":"Serine","cca":"Proline","caa":"Glutamine","ccc":"Proline","tat":"Tyrosine",
"ggt":"Glycine","tgt":"Cysteine","cga":"Arginine","cag":"Glutamine","tct":"Serine","gat":"AsparticAcid","cgg":"Arginine",
"ttt":"Phenylanaline","tgc":"Cysteine","ggg":"Glycine","tag":"*","gga":"Glycine","taa":"*","ggc":"Glycine",
"tac":"Tyrosine","ttc":"Phenylanaline","tcg":"Serine","tta":"Leucine","ttg":"Leucine","tcc":"Serine","acc":"thronine",
"tca":"Serine","gca":"Alanine","gta":"Valine","gcc":"Alanine","gtc":"Valine","gcg":"Alanine","gtg":"Valine",
"gag":"GlutamicAcid","gtt":"Valine","gct":"Alanine","tga":"*","gac":"AsparticAcid","cgt":"Arginine","tgg":"Tryptophane",
"gaa":"GlutamicAcid","cgc":"Arginine"}

cont=0

nomFich = raw_input("File: ")

#open file
f = open(nomFich)
contA = contG = contC = contT = 0;
baseCodonNum = 0
baseCodon = ""
codones = []
aminoAcidos = []
numberAminoAcids = {}
totalAminoAcids = 0
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
				totalAminoAcids+=1
				baseCodonNum = 0
				codones.append(baseCodon)
				aminoAcidos.append(tabla[baseCodon])
				if (numberAminoAcids.has_key(tabla[baseCodon])):
					numberAminoAcids[tabla[baseCodon]]+=1
				else:
					numberAminoAcids[tabla[baseCodon]]=1

				baseCodon = ""

	cont+=1

#closing files
f.close()
print "1: Contar cuantas veces aparece cada una de las bases en la cadena de DNA."
print "2: convertir todo el DNA en aminoacidos y guardarlo en un fichero llamado amino.txt"	
print "3: Count the differents amino acids"
print "4: Show the amino acids that appears more than a percentege"
print "0: Exit"
option = input("Option: ")
while(option != 0) :
	print ""
	if(option == 1) :
		print "As: " + str(contA) + " Gs: " + str(contG) + " Cs: " + str(contC) + " Ts: " + str(contT)
	elif (option == 2) :
		print "Writing the file..."
		fichEscri = open("amino.txt", "w")
		fichEscri.write(str(aminoAcidos))
		fichEscri.close()
	elif (option == 3) :
		print numberAminoAcids
	elif (option == 4 ) :
		printAADependsOnPer(totalAminoAcids, numberAminoAcids)
	elif (option == 0) :
		print "You pressed exit..."
	else :
		print "Wrong key"

	print ""
	#
	print "1: Contar cuantas veces aparece cada una de las bases en la cadena de DNA."
	print "2: convertir todo el DNA en aminoacidos y guardarlo en un fichero llamado amino.txt"
	print "3: Count the differents amino acids"
	print "4: Show the amino acids that appears more than a percentege"
	print "0: Exit"
	option = input("Option: ")
	#print "As: " + str(contA) + " Gs: " + str(contG) + " Cs: " + str(contC) + " Ts: " + str(contT)

	

