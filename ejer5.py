diccionario = {}

while True :
	clave = raw_input("param1: ")
	if not diccionario.has_key(clave) :
		diccionario[clave] = raw_input("param2: ")
		print diccionario
	else :
		print diccionario[clave]
