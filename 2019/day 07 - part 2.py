binary=""

def GetBit(val,idx):
	tmpval=int(val/10**(idx-1))
	return tmpval-int(tmpval/10)*10

def Execute(opc, inp=None):
	def Get(idx,immediate):
		if immediate==1:
			return opc[idx]
		return opc[opc[idx]]
	curinp=0
	def GetInput(idx):
		if idx>=len(inp):
			return int(input("insert the input: "))
		else:
			return inp[idx]
		
	cnt=0
	prints=[]
	while True:
		try:
			inst=opc[cnt]
			cur=inst-int(inst/100)*100
			if cur==1:
				val1=Get(cnt+1,GetBit(inst,3))
				val2=Get(cnt+2,GetBit(inst,4))
				opc[opc[cnt+3]]=val1+val2
				cnt+=3
			elif cur==2:
				val1=Get(cnt+1,GetBit(inst,3))
				val2=Get(cnt+2,GetBit(inst,4))
				opc[opc[cnt+3]]=val1*val2
				cnt+=3
			elif cur==3:
				opc[opc[cnt+1]]=GetInput(curinp)
				curinp+=1
				cnt+=1
			elif cur==4:
				prints.append(Get(cnt+1,0))
				cnt+=1
			elif cur==5:
				val1=Get(cnt+1,GetBit(inst,3))
				if val1!=0:
					cnt=Get(cnt+2,GetBit(inst,4))-1
				else:
					cnt+=2
			elif cur==6:
				val1=Get(cnt+1,GetBit(inst,3))
				if val1==0:
					cnt=Get(cnt+2,GetBit(inst,4))-1
				else:
					cnt+=2
			elif cur==7:
				val1=Get(cnt+1,GetBit(inst,3))
				val2=Get(cnt+2,GetBit(inst,4))
				if val1<val2:
					opc[opc[cnt+3]]=1
				else:
					opc[opc[cnt+3]]=0
				cnt+=3
			elif cur==8:
				val1=Get(cnt+1,GetBit(inst,3))
				val2=Get(cnt+2,GetBit(inst,4))
				if val1==val2:
					opc[opc[cnt+3]]=1
				else:
					opc[opc[cnt+3]]=0
				cnt+=3
			elif cur==99:
				break
			else:
				print("undefined opcode:",cur)
				break
			cnt+=1
		except ...:
			print("error")
			break
	return prints

program=[int(x) for x in binary.split(",")]
print("part 1:")
ret=0
for A in range(5):
	resA=Execute(program.copy(),[A,0])[-1]
	print(resA)
	itA=list(range(5))
	itA.remove(A)
	for B in itA:
		resB=Execute(program.copy(),[B,resA])[-1]
		itB=itA.copy()
		itB.remove(B)
		for C in itB:
			resC=Execute(program.copy(),[C,resB])[-1]
			itC=itB.copy()
			itC.remove(C)
			for D in itC:
				resD=Execute(program.copy(),[D,resC])[-1]
				itD=itC.copy()
				itD.remove(D)
				for E in itD:
					ret=max(ret,Execute(program.copy(),[E,resD])[-1])
print("solution is:",ret)