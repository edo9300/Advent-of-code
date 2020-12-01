from fractions import Fraction
def CheckDiagonal(pt1,pt2):
	if pt1[0] == pt2[0]: #same y value, just check the closest x
		if pt1[1]<pt2[1]:
			for i in range(pt1[1]+1, pt2[1]):
				if aa[pt1[0]][i]=="#":
					return 0
		if pt1[1]>pt2[1]:
			for i in range(pt2[1]+1, pt1[1]):
				if aa[pt2[0]][i]=="#":
					return 0
		return 1
	elif pt1[1] == pt2[1]: #same x value, just check the closest y
		if pt1[0]<pt2[0]:
			for i in range(pt1[0]+1, pt2[0]):
				if aa[i][pt1[1]]=="#":
					return 0
		if pt1[0]>pt2[0]:
			for i in range(pt2[0]+1, pt1[0]):
				if aa[i][pt2[1]]=="#":
					return 0
		return 1
	else:
		pt1,pt2=sorted([pt1,pt2])
		# print(pt1,pt2)
		ratio=Fraction(pt2[1]-pt1[1],pt2[0]-pt1[0])
		print("ratio",ratio)
		# print(list(range(pt1[0]+1,pt2[0])))
		for y in range(pt1[0]+1,pt2[0]):
			# if not (y*ratio).is_integer():
				# continue
			# for x in range(pt1[1]+1,pt2[1],pt2[1]-pt1[1]):
			x=y*ratio
			if pt1[1]<pt2[1]:
				x=max(pt2[1],pt1[1])-y*ratio
			print("max",y,max(pt2[1],pt1[1])-y*ratio)
			print("direct pt2:",y,pt2[1]-y*ratio)
			print("direct pt2:",y,pt1[1]-y*ratio)
			print("ratio",y,y*ratio)
			print("x",y,x)
			try:
				if aa[y][x]=="#":
					return 0
			except (IndexError, TypeError) as e:
				continue
		return 1
	return 0

# print(sorted([tuple([1,0]),tuple([0,3])]))
# aa=[list(c) for c in [x for x in open("in10","r").read().split()]]
aa=[list(c) for c in [x for x in open("in10tst","r").read().split()]]
# print(aa)
# print(lines)
grid={}

for y in range(len(aa)):
	for x in range(len(aa[y])):
		if aa[y][x]!="#":
			continue
		# print(aa[y][x],end="")
		for y2 in range(len(aa)):
			for x2 in range(len(aa[y2])):
				if (x!=x2 or y!=y2) and aa[y2][x2]=="#":
					grid[tuple([y,x])]=grid.get(tuple([y,x]),0)+CheckDiagonal(tuple([y,x]),tuple([y2,x2]))
print(grid)
	# print("")
# print(list(range(1,2)))
m=0
for k in grid.values():
	m=max(m,k)
print(m)


