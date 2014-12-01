#http://wwpdb.org/documentation/format33/v3.3.html

#De la entrada de PDB hay que guardar el identificador, la fecha en la que se creo la entrada,
# el titulo, las moleculas que contiene junto con el nombre de la molecula, las cadenas de cada molecula,
# las secuencias de cada cadena, su longitud y las referencias de cada cadena a las correspondientes entradas de UniProt.

import sys
import re
import psycopg2 as dbi


dbhost='localhost'	
dbname='masterdb'	
dbuser='masteruser'	
dbpass='masterpass' 

def parse(line) :
	line = line.rstrip('\n')
	palabras = line.split(" ")
	finalPal = []
	for palabra in palabras :
		if palabra != "" :
			finalPal.append(palabra)
	return finalPal

if len(sys.argv)>1 :
	for infile in sys.argv[1:]:
		fichero = open(str(infile))
		fheader = []
		ftitle = []
		fcompnd = []
		for line in fichero :
			if line.startswith("HEADER") :
				header = parse(line)
				del header[0]
				fheader.append(header)
				print (fheader)
			elif line.startswith("TITLE") :
				title = parse(line)
				del title[0]
				print (title)
			elif line.startswith("COMPND") :
				compnd = parse(line)
				del compnd[0]
				print (compnd)