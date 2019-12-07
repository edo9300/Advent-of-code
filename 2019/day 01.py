file=open("input1.txt","r",encoding="UTF-8")
total=0
for line in file:
	total+=int(line)//3-2
print("result 1:",total)

def GetFuel(input):
	if input<6:
		return 0
	return (input//3)-2 + GetFuel((input//3)-2)
file.seek(0)
file=open("input1.txt","r",encoding="UTF-8")
total=0
for line in file:
	total+=GetFuel(int(line))
print("result 2:",total)
file.close()