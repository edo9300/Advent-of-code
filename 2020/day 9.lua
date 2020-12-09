local complete_stack={}
local partial_stack={}
local part1=nil
for line in io.open("in9.txt"):lines() do
	local val=tonumber(line)
	if val then
		table.insert(complete_stack,val)
		if not part1 and #partial_stack>=25 then
			for i1,val1 in ipairs(partial_stack) do
				for i2,val2 in ipairs(partial_stack) do
					if i1~=i2 then
						if val1+val2==val then
							goto stop
						end
					end
				end
			end
			part1=val
			::stop::
			table.insert(partial_stack,val)
			table.remove(partial_stack,1)
		else
			table.insert(partial_stack,val)
		end
	end
end
local part2=nil
for idx,val in ipairs(complete_stack) do
	local cur=0
	for i=idx+1,#complete_stack do
		cur=cur+complete_stack[i]
		if cur==part1 then
			part2=math.max(table.unpack(complete_stack,idx,i))+math.min(table.unpack(complete_stack,idx,i))
			goto stop2
		end
	end
end
::stop2::
print("Part 1: "..part1)
print("Part 2: "..part2)