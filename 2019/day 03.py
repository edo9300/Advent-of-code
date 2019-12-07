def Parse(wire):
	ops=wire.strip().split(",")
	res=[]
	for op in ops:
		res.append((op[0],int(op[1:])))
	return res

file=open("input3.txt","r",encoding="UTF-8")
grid={}
wire1=Parse(file.readline())
wire2=Parse(file.readline())
file.close()
crossed=[]
subgrid=[{},{}]
a=-1
for wire in (wire1,wire2):
	coords=[0,0]
	a+=1
	step=0
	for op in wire:
		incx=0
		incy=0
		if op[0]=="U":
			incy=-1
		elif op[0]=="D":
			incy=1
		elif op[0]=="L":
			incx=-1
		elif op[0]=="R":
			incx=1
		for f in range(op[1]):
			step+=1
			coords[0]+=incx
			coords[1]+=incy
			val=grid.get(tuple(coords),0)+1
			grid[tuple(coords)]=val
			if val>1 and tuple(coords) not in subgrid[a]:
				crossed.append([*coords])
			if not tuple(coords) in subgrid[a]:
				subgrid[a][tuple(coords)]=step

mind=None
for point in crossed:
	if mind==None:
		mind=abs(point[0])+abs(point[1])
		continue
	val=abs(point[0])+abs(point[1])
	if val<min:
		mind=val
print(mind)

minstep=None
for point in crossed:
	val1=subgrid[0][tuple(point)]
	val2=subgrid[1][tuple(point)]
	val=val1+val2
	if minstep:
		minstep=min(minstep,val)
	else:
		minstep=val
print(minstep)
