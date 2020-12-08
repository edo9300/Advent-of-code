local stack={}
for line in io.open("in8.txt"):lines() do
	local op,val=line:match("(%a+) (.+)")
	table.insert(stack,{op,tonumber(val)})
end
local tot=#stack

function run()
	local i=1
	local acc=0
	local visited={}
	while i<=tot do
		if visited[i] then return acc,true end
		visited[i]=true
		local curop=stack[i]
		if curop[1]=="jmp" then
			i=i+curop[2]
		else
			if curop[1]=="acc" then
				acc=acc+curop[2]
			end
			i=i+1
		end
	end
	return acc,false
end

function checkpatched()
	function patch(ins)
		if ins=="nop" then return "jmp" end
		return "nop"
	end
	for i=1,tot do
		if stack[i][1]~="acc" then
			stack[i][1]=patch(stack[i][1])
			local res,fail=run()
			if not fail then return res end
			stack[i][1]=patch(stack[i][1])
		end
	end
end

print("Part 1: "..run())
print("Part 2: "..checkpatched())