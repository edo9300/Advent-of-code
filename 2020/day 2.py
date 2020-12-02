with open("in2.txt") as f:
	valids=0
	valids2=0
	for line in f.readlines():
		toks=line.split(":")
		tomatch=toks[1]
		toks=toks[0].split(" ")
		letter=toks[1]
		bounds=toks[0].split("-")
		start=int(bounds[0])
		stop=int(bounds[1])
		amt=tomatch.count(letter)
		if amt<=stop and amt>=start:
			valids+=1
		if ((1 if (tomatch[start]==letter) else 0) + (1 if (tomatch[stop]==letter) else 0))==1:
			valids2+=1
print("Part 1",valids)
print("Part 2",valids2)