input="..."

function compose(str)
	local s={}
	local prev=nil
	local amount=0
	for c in string.gmatch(str,".") do
		if prev==c then
			amount=amount+1
		else
			if prev then
				table.insert(s,tostring(amount))
				table.insert(s,prev)
			end
			amount=1
			prev=c
		end
	end
	if prev then
		table.insert(s,tostring(amount))
		table.insert(s,prev)
	end
	return table.concat(s, "")
end

for i=1,50 do
	if i==41 then
		print("Part 1: "..#input)
	end
	input=compose(input)
end
print("Part 2: "..#input)