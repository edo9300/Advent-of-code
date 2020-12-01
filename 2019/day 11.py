def GetBit(val,idx):
	tmpval=int(val/10**(idx-1))
	return tmpval-int(tmpval/10)*10


def Execute(opc,pc=0, inp=[]):
	immediateofs=0
	def Get(idx,immediate):
		if immediate==1:
			return opc[idx]
		elif immediate==2:
			return opc.get(opc[idx]+immediateofs,0)
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
				opc[WithOffset(cnt+3,5)]=val1+val2
				cnt+=3
			elif cur==2:
				val1=Get(cnt+1,GetBit(inst,3))
				val2=Get(cnt+2,GetBit(inst,4))
				opc[WithOffset(cnt+3,5)]=val1*val2
				cnt+=3
			elif cur==3:
				# print(len(inp))
				if len(inp)==curinp:
					status="needs input"
					return prints.copy(),cnt,status
				opc[WithOffset(cnt+1,3)]=GetInput(curinp)
				curinp+=1
				cnt+=1
			elif cur==4:
				prints.append(Get(cnt+1,GetBit(inst,3)))
				status="has value"
				# print(cnt)
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

binary=open("in11","r").read().strip()
program=[int(x) for x in binary.split(",")]
prglistorg={i:program[i] for i in range(len(program))}
prglist=prglistorg.copy()
#print("part 1:",Execute(prglist,[1])[-1])
#print("part 2:",Execute(prglist,[2])[-1])
turn_left={}
turn_left["UP"]="LEFT"
turn_left["LEFT"]="DOWN"
turn_left["DOWN"]="RIGHT"
turn_left["RIGHT"]="UP"
turn_right={}
turn_right["UP"]="RIGHT"
turn_right["RIGHT"]="DOWN"
turn_right["DOWN"]="LEFT"
turn_right["LEFT"]="UP"
turn=[turn_left,turn_right]
move={}
move["UP"]=[-1,0]
move["DOWN"]=[1,0]
move["LEFT"]=[0,-1]
move["RIGHT"]=[0,1]
pc=0
inp=[]
status="continue"
pos=[0,0]
direction="UP"
prints=[]
grid={}
while False:
	if len(prints):
		color=prints[0]
		rotation=prints[1]
		grid[tuple(pos)]=color
		direction=turn[rotation][direction]
		pos[0]+=move[direction][0]
		pos[1]+=move[direction][1]
		
	if status=="halt":
		break
	if status=="needs input":
		inp=[grid.get(tuple(pos),0)]
	prints,pc,status=Execute(prglist,pc,inp)
#print(grid)
print("part 1:",len(grid))

prglist=prglistorg.copy()
pc=0
inp=[]
status="continue"
pos=[0,0]
direction="UP"
prints=[]
grid2={}
grid2[tuple([0,0])]=1
while True:
	if len(prints)>0:
		# print(pc)
		color=prints[0]
		rotation=prints[1]
		# if not tuple(pos) in grid2:
		grid2[tuple(pos)]=color
		# print(grid2)
		# print(direction, rotation)
		direction=turn[rotation][direction]
		pos[0]+=move[direction][0]
		pos[1]+=move[direction][1]
		
	if status=="halt":
		break
	if status=="needs input":
		inp=[grid2.get(tuple(pos),0)]
	# print(inp)
	prints,pc,status=Execute(prglist,pc,inp)



miny=min(grid2.items(), key=lambda x: x[0][0])[0][0]
print(miny)
minx=min(grid2.items(), key=lambda x: x[0][1])[0][1]
print(minx)
maxy=max(grid2.items(), key=lambda x: x[0][0])[0][0]
print(maxy)
maxx=max(grid2.items(), key=lambda x: x[0][1])[0][1]
print(maxx)
print(grid2)
print(list(range(miny,maxy)))
print(list(range(minx,maxx)))
for y in range(miny,maxy):
	for x in range(minx,maxx):
		val=grid2.get(tuple([y,x]),0)
		if val==0:
			val=" "
		else:
			val="#"
		print(val,end="")
	print("")
