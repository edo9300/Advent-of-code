binary=""

def GetBit(val,idx):
	tmpval=int(val/10**(idx-1))
	return tmpval-int(tmpval/10)*10

def Execute(opc, inp=None):
	def Get(idx,immediate):
		if immediate==1:
			return opc[idx]
		return opc[opc[idx]]
		
	def GetInput():
		if inp:
			return inp
		return int(input("insert the input: "))
		
	cnt=0
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
				opc[opc[cnt+1]]=GetInput()
				cnt+=1
			elif cur==4:
				print(Get(cnt+1,0))
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

program=[int(x) for x in binary.split(",")]
print("part 1:")
Execute(program.copy(),1)
print("part 2:")
Execute(program.copy(),5)