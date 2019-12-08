binary=""

def GetBit(val,idx):
	tmpval=int(val/10**(idx-1))
	return tmpval-int(tmpval/10)*10

class Amp:
	def __init__(self,program,input=None):
		self.memory=[]
		self.pc=0
		self.status=None
		self.prints=[]
		self.memory = program.copy()
		self.prints,self.pc,self.status=Execute(self.memory,self.pc,input)
	def GetStatus(self):
		return self.status
	def SetInput(self,input):
		self.prints,self.pc,self.status=Execute(self.memory,self.pc,input)
		return self.status
	def GetPrints(self):
		ret=self.prints.copy()
		self.prints.clear()
		return ret
	def HasValue(self):
		return len(self.prints)>0
		

def Execute(opc, pc=0, inp=None):
	def Get(idx,immediate):
		if immediate==1:
			return opc[idx]
		return opc[opc[idx]]
	curinp=0
	def GetInput(idx):
		if idx>=len(inp):
			return None
		else:
			return inp[idx]
		
	cnt=pc
	prints=[]
	status="continue"
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
				if GetInput(curinp)==None:
					status="needs input"
					return prints.copy(),cnt,status
				opc[opc[cnt+1]]=GetInput(curinp)
				curinp+=1
				cnt+=1
			elif cur==4:
				prints.append(Get(cnt+1,0))
				status="has value"
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
				status="halt"
				break
			else:
				print("undefined opcode:",cur)
				break
			cnt+=1
		except ...:
			print("error")
			break
	return prints.copy(),cnt,status

def Evaluate(program,params):
	def InitAmplifiers():
		res=[]
		for param in params:
			res.append(Amp(program,[param]))
		return res
	amps=InitAmplifiers()
	cnt=0
	ret=[0]
	while True:
		if amps[cnt].HasValue():
			ret=amps[cnt].GetPrints()
		if amps[cnt].GetStatus()=="halt":
			break
		if amps[cnt].GetStatus()=="continue":
			cnt=(cnt+1)%5
			continue
		if amps[cnt].GetStatus()=="needs input":
			amps[cnt].SetInput(ret)
			if amps[cnt].HasValue():
				ret=amps[cnt].GetPrints()
		cnt=(cnt+1)%5
	return ret

program=[int(x) for x in binary.split(",")]
print("part 2:")
ret=0
for A in range(5,10):
	itA=list(range(5,10))
	itA.remove(A)
	for B in itA:
		itB=itA.copy()
		itB.remove(B)
		for C in itB:
			itC=itB.copy()
			itC.remove(C)
			for D in itC:
				itD=itC.copy()
				itD.remove(D)
				for E in itD:
					ret=max(ret,Evaluate(program,[A,B,C,D,E])[-1])
print("solution is:",ret)