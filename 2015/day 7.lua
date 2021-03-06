input=io.open("in7.txt")

functions={}
vals={}

function getreg(from)
	return tonumber(from) or vals[from] or (functions[from] and functions[from]())
end

function setreg(reg,val)
	vals[reg]=val
end

function setfunc(reg,val)
	functions[reg]=val
end

if input then
	for line in input.lines(input) do
		if string.find(line, "AND") then
			local from1,from2,to = string.match(line, "(%S+) AND (%S+) %-> (%a+)")
			setfunc(to,function()
				local arg1=getreg(from1)
				if not arg1 then return end
				local arg2=getreg(from2)
				if not arg2 then return end
				setreg(to,arg1&arg2)
				return vals[to]
			end)
		elseif string.find(line, "OR") then
			local from1,from2,to = string.match(line, "(%S+) OR (%S+) %-> (%a+)")
			setfunc(to,function()
				local arg1=getreg(from1)
				if not arg1 then return end
				local arg2=getreg(from2)
				if not arg2 then return end
				setreg(to,arg1|arg2)
				return vals[to]
			end)
		elseif string.find(line, "LSHIFT") then
			local from,amount,to = string.match(line, "(%S+) LSHIFT (%d+) %-> (%a+)")
			local amount=tonumber(amount)
			setfunc(to,function()
				local arg=getreg(from)
				if not arg then return end
				setreg(to,(arg<<amount)&0xffff)
				return vals[to]
			end)
		elseif string.find(line, "RSHIFT") then
			local from,amount,to = string.match(line, "(%S+) RSHIFT (%d+) %-> (%a+)")
			local amount=tonumber(amount)
			setfunc(to,function()
				local arg=getreg(from)
				if not arg then return end
				setreg(to,arg>>amount)
				return vals[to]
			end)
		elseif string.find(line, "NOT") then
			local from,to = string.match(line, "NOT (%S+) %-> (%a+)")
			setfunc(to,function()
				local arg=getreg(from)
				if not arg then return end
				setreg(to,(~arg)&0xffff)
				return vals[to]
			end)
		elseif string.find(line, "->") then
			local what,to = string.match(line, "(%S+) %-> (%a+)")
			setfunc(to,function()
				local arg=getreg(what)
				if not arg then return end
				setreg(to,arg&0xffff)
				return vals[to]
			end)
		else
			print("unrecognized operation: "..line)
		end
	end
	local part1=getreg("a")
	print("Part 1: "..part1)
	vals={}
	setfunc("b",function()
				setreg("b",part1)
				return vals["b"]
			end)
	print("Part 2: "..getreg("a"))
end