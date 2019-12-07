binary=""

stop=False
noun=0
verb=0
def Calculate(i,j):
	opc=[int(x) for x in binary.split(",")]
	opc[1]=i
	opc[2]=j
	cnt=0
	while True:
		try:
			cur=opc[cnt]
			if cur==1:
				val1=opc[opc[cnt+1]]
				val2=opc[opc[cnt+2]]
				opc[opc[cnt+3]]=val1+val2
				cnt+=3
			elif cur==2:
				val1=opc[opc[cnt+1]]
				val2=opc[opc[cnt+2]]
				opc[opc[cnt+3]]=val1*val2
				cnt+=3
			else:
				return opc[0]
				break
			cnt+=1
		except:
			break
	return 0

#part 1
print("part 1:",Calculate(12,2))

#part 2
for i in range(99):
	if stop:
		break
	for j in range(99):
		if Calculate(i,j)==19690720:
			stop=True
			print("part 2:",100*i+j)
			break
