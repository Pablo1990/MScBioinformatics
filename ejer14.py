#Regular expression import
import re

##exercise 14
dna = raw_input("DNA: ")
rna = re.sub('T', 'U', dna.upper())
print "RNA: " + rna