#ej1Exam
lista = [0,1,1,1,3,4,3,2,1,3,21,1,1,1,1,23,4,4,6,7]

num = int(input("Introduce numero: "))

cont=0
for i in lista :
	if(i==num) :
		cont+=1

print "Aparece " + str(cont) + " veces"

#ej2Exam
import re

fich = open("genbank.gb")

for linea in fich :
	if re.search("JOURNAL", linea) :
		print "Revista: " + linea.split("JOURNAL ")[1]
	elif re.search("AUTHORS", linea) :
		print "Autores: " + linea.split("AUTHORS")[1]

#ej3Exam

producto=['arroz', 'harina', 'leche', 'garbanzos']

cantidad = [4,5,3,65]

precio = [10,15,20,21]

num = 0
dic={}
for num in range(len(producto)) :
	dic[producto[num]]=cantidad[num]*precio[num]

print dic

#ej4
import re

while True :
	hora = raw_input("Introduzca hora: ")
	if(re.match("^(([0-1][0-9])|(2[0-3])):([0-5][0-9]):([0-5][0-9])$", hora)) :
		nums = hora.split(":")
		print "Son las " + str(nums[0]) + " horas, " + str(nums[1]) + " minutos y " + str(nums[2]) + " segundos"
	else :
		print "MEEEEEC, ERROR"

#ej5
array = [2,4,5,7,8,9,4]

for temp in range(2,len(array),2) :
	print "El numero es:",array[temp]

#ej6
def dosElevadoA(num) :
	if num==0 :
		return 1
	else :
		return 2*dosElevadoA(num-1)

while True :
	print dosElevadoA(input("Num: "))
