nomFich = raw_input("Fichero: ")
#open files

tabla={"ctt":"l","atg":"m","aca":"t","acg":"t","atc":"i","aac":"n",
"ata":"i","agg":"r","cct":"p","act":"t","agc":"s","aag":"k","aga":"r",
"cat":"h","aat":"n","att":"i","ctg":"l","cta":"l","ctc":"l","cac":"h",
"aaa":"k","ccg":"p","agt":"s","cca":"p","caa":"q","ccc":"p","tat":"y",
"ggt":"g","tgt":"c","cga":"r","cag":"q","tct":"s","gat":"d","cgg":"r",
"ttt":"f","tgc":"c","ggg":"g","tag":"*","gga":"g","taa":"*","ggc":"g",
"tac":"y","ttc":"f","tcg":"s","tta":"l","ttg":"l","tcc":"s","acc":"t",
"tca":"s","gca":"a","gta":"v","gcc":"a","gtc":"v","gcg":"a","gtg":"v",
"gag":"e","gtt":"v","gct":"a","tga":"*","gac":"d","cgt":"r","tgg":"w",
"gaa":"e","cgc":"r"}

cont=0
f = open(nomFich)
contA = contG = contC = contT = 0;
baseCodonNum = 0
baseCodon = ""
codones = []
aminoAcidos = []
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
				aminoAcidos.append(tabla[baseCodon])
				baseCodon = ""

	cont+=1

print aminoAcidos
print codones
#closing files
f.close()

print "As: " + str(contA) + " Gs: " + str(contG) + " Cs: " + str(contC) + " Ts: " + str(contT)