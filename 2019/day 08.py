def IndexSplit(string,index):
	cur=0
	res=[]
	while cur<len(string):
		st=string[cur:cur+index]
		res.append(st)
		cur+=index
	return res

def ApplyMask(grid):
	res=[{}]
	for line in reversed(grid):
		a=0
		for st in line:
			if len(res)<=a:
				res.append({})
			for i in range(len(st)):
				if res[a].get(i,"2")=="2" or st[i]!="2":
					res[a][i]=st[i]
			a+=1
	return res

def Map(ch):
	if ch=="0":
		return " "
	if ch=="1":
		return "#"
	return "."

width=25
height=6
file=open("input 8.txt","r",encoding="UTF-8")
image=file.read()
file.close()
grid=[]
count0=width*height
counttot=0
for  st in IndexSplit(image,width*height):
	if st.count("0")<count0:
		count0=st.count("0")
		counttot=st.count("1")*st.count("2")
	grid.append(IndexSplit(st,width))

print("Part 1:",counttot)
print("Part 2:\n")
for a in ApplyMask(grid):
	for b in a.values():
		print(Map(b),end="")
	print("")