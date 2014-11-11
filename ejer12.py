def multipliPosition(line, col) :
	total=0
	for i in range(len(col)) :
		total+=line[i]*col[i]
	return total

def multipliMatrix(matrix1, matrix2) :
	result=[]
	for line1 in matrix1 :
		filaRes=[]
		for i in range(len(matrix2)) :
			col=[]
			for line2 in matrix2 :
				col.append(line2[i])
			filaRes.append(multipliPosition(line1, col))

		result.append(filaRes)

	return result

def readMatrix(nameFile) :
	file1 = open(nameFile)
	rawMatrix = file1.readLines()
	matrix = rawMatrix.split('\n')
	return matrix.split(' ')


#Predefined matrix
#x = [[1,2],[4,5],[7,8],[10,11]]
#y = [[1,2,5],[1,2,6]]
salute = 1

while salute!=3 :
	print("Option 1: I want to enter two matrices with the standard input")
	print("Option 2: I want to enter the name of two files wich are the matrices")
	print("Option 3: I want you")
	salute = input("Hi, what do you want to do? ")
	
	x=[]
	y=[]
	if(salute == 1) :
		tam11 = input("Introduce number of files of matrix 1: ")
		tam12 = input("Introduce number of columns of matrix 1: ")
		tam21 = input("Introduce number of files of matrix 2: ")
		tam22 = input("Introduce number of columns of matrix 2: ")

		
		for i in range(tam11) :
			line = []
			for j in range(tam12) :
				line.append(input("Introduce position " + str(i) + ", " + str(j)+ ": "))
			x.append(line)

		
		for i in range(tam21) :
			line = []
			for j in range(tam22) :
				line.append(input("Introduce position " + str(i) + ", " + str(j) + ": "))
			y.append(line)
	elif (salute==2) :
		nomFich1 = input("Introduce the name of the first file: ")
		x = readMatrix(nomFich1)
		nomFich2 = input("Introduce the name of the second file: ")
		y = readMatrix(nomFich2)
		


	#Do the multiplication
	#print x
	#print y
	if(salute!=3) :
		if(len(x[0])==len(y)) :
			print multipliMatrix(x,y)
		else :
			print "Incompatibles matrix"
	else :
		print "Well... See you!"
