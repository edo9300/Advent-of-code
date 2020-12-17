import re

def bits(n):
	while n:
		b = n & (~n+1)
		yield b
		n ^= b

def calcaddress(stack,addr):
	if len(stack)==0:
		return (addr,);
	val=stack.pop()
	ret=calcaddress(stack,addr|val)+calcaddress(stack,addr&(~val))
	stack.append(val)
	return ret


with open("in14.txt") as f:
	mem={}
	mem2={}
	for line in f.readlines():
		if line.startswith("mask"):
			mask1=0
			mask2=0
			i=0
			for c in reversed(line[7:-1]):
				if c=="X":
					mask1 |= 1<<i
				else:
					mask2 |= int(c)<<i
				i+=1;
		else:
			matched=re.match("mem\[(\d+)\] = (\d+)",line).groups()
			address=int(matched[0])
			value=int(matched[1])
			mem[address]=mask2|(value&mask1)
			
			for addr in calcaddress([*bits(mask1)],mask2|address):
				mem2[addr]=value
	
	print("Part 1", sum(mem.values()))
	print("Part 2", sum(mem2.values()))