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
		if stop>=amt>=start:
			valids+=1
		if (tomatch[start]==letter) != (tomatch[stop]==letter):
			valids2+=1
print("Part 1",valids)
print("Part 2",valids2)