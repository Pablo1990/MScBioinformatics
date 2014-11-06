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

#Predefined matrix
#x = [[1,2],[4,5],[7,8],[10,11]]
#y = [[1,2,5],[1,2,6]]

tam11 = input("Introduce number of files of matrix 1: ")
tam12 = input("Introduce number of columns of matrix 1: ")
tam21 = input("Introduce number of files of matrix 2: ")
tam22 = input("Introduce number of columns of matrix 2: ")

x=[]
for i in range(tam11) :
	line = []
	for j in range(tam12) :
		line.append(input("Introduce position " + str(i) + ", " + str(j)+ ": "))
	x.append(line)

y=[]
for i in range(tam21) :
	line = []
	for j in range(tam22) :
		line.append(input("Introduce position " + str(i) + ", " + str(j) + ": "))
	y.append(line)

print x
print y

if(len(x[0])==len(y)) :
	print multipliMatrix(x,y)
else :
	print "Incompatibles matrix"
