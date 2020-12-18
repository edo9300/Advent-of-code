def evaluate(operation):
	lhs=operation["lhs"] if type(operation["lhs"]) is int else evaluate(operation["lhs"])
	rhs=operation["rhs"] if type(operation["rhs"]) is int else evaluate(operation["rhs"])
	# print(lhs,operation["op"],rhs)
	if operation["op"]=="+":
		return lhs+rhs
	return lhs*rhs

with open("in18.txt") as f:
	tot=0
	for line in f.readlines():
		stack=[]
		curop={}
		stack.append(curop)
		# print(line)
		for token in line.replace("(", "( ").replace(")", " )").split():
			# print(token)
			if token=="(":
				curop={}
				stack.append(curop)
			elif token==")":
				prevop=curop
				stack.pop()
				curop=stack[-1]
				if not "lhs" in curop.keys():
					curop["lhs"]=prevop
				else:
					curop["rhs"]=prevop
					if "multistack" in curop.keys():
						prevop=curop
						stack.pop(-2)
						curop=stack[-1]
			elif token=="*" or token=="+":
				if "op" in curop.keys():
					prevop=curop
					curop={}
					stack.append(curop)
					curop["lhs"]=prevop
					curop["op"]=token
					curop["multistack"]=True
				else:
					curop["op"]=token
			else:
				if not "lhs" in curop.keys():
					curop["lhs"]=int(token)
				else:
					curop["rhs"]=int(token)
					# print(curop)
					if "multistack" in curop.keys():
						prevop=curop
						stack.pop(-2)
						curop=stack[-1]
		if not "rhs" in curop.keys():
			curop=prevop
		# print(curop)
		tot+=evaluate(curop)
					
	print("Part 1:",tot)