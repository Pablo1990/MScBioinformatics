def factorial(number) :
	total= 1
	for i in range(1,number+1) :
		total*=i

	return total

def factorialRecursive(number) :
	if(number==1) :
		return 1
	else :
		return number * factorialRecursive(number-1)

numFactorial = input("Number: ")
print factorial(numFactorial)
print factorialRecursive(numFactorial)

