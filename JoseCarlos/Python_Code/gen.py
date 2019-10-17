from random import *

n = 500
eps = 1.0/n
maxr = n/2

print(n)

f = open("data.in","w")
f.write(str(eps) + " " + str(n))

for i in range(n):
    f.write(" " + str(randint(1,maxr)))
f.write("\n")

f.close()

