def GetBit(val,idx):
	tmpval=int(val/10**(idx-1))
	return tmpval-int(tmpval/10)*10


def Execute(opc, inp=[]):
	immediateofs=0
	def Get(idx,immediate):
		if immediate==1:
			return opc[idx]
		elif immediate==2:
			return opc[opc[idx]+immediateofs]
		return opc.get(opc[idx],0)

	inst=0
	def WithOffset(idx,bit):
		if GetBit(inst,bit)==2:
			return opc.get(idx,0)+immediateofs
		return opc.get(idx,0)

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
				opc[WithOffset(cnt+3,5)]=val1+val2
				cnt+=3
			elif cur==2:
				val1=Get(cnt+1,GetBit(inst,3))
				val2=Get(cnt+2,GetBit(inst,4))
				opc[WithOffset(cnt+3,5)]=val1*val2
				cnt+=3
			elif cur==3:
				opc[WithOffset(cnt+1,3)]=GetInput(curinp)
				curinp+=1
				cnt+=1
			elif cur==4:
				prints.append(Get(cnt+1,GetBit(inst,3)))
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
					opc[WithOffset(cnt+3,5)]=1
				else:
					opc[WithOffset(cnt+3,5)]=0
				cnt+=3
			elif cur==8:
				val1=Get(cnt+1,GetBit(inst,3))
				val2=Get(cnt+2,GetBit(inst,4))
				if val1==val2:
					opc[WithOffset(cnt+3,5)]=1
				else:
					opc[WithOffset(cnt+3,5)]=0
				cnt+=3
			elif cur==9:
				immediateofs+=Get(cnt+1,GetBit(inst,3))
				cnt+=1
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

binary=open("in9","r").read().strip()
program=[int(x) for x in binary.split(",")]
prglist={i:program[i] for i in range(len(program))}

print("part 1:",Execute(prglist,[1])[-1])
print("part 2:",Execute(prglist,[2])[-1])