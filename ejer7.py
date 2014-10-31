nomFich = raw_input("Fichero: ")
#open files
palabras = {}
f = open(nomFich)
for line in f:
	#processinng
	wordsLinea = line.split(' ')
	for palabra in wordsLinea:
		if (palabras.has_key(palabra)):
			palabras[palabra]+=1
		else:
			palabras[palabra]=1


#closing files
f.close()

print palabras.items()