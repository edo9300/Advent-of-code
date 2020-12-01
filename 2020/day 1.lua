local input=io.open("in1.txt")
local values={}
if input then
	for line in input.lines(input) do
		local value=tonumber(line)
		if value then
			table.insert(values, tonumber(line))
		end
	end
end

values1={table.unpack(values)}

while true do
	local matching=table.remove(values,1)
	if not matching then goto part2 end
	for _,val in ipairs(values) do
		if matching+val==2020 then
			print("Part 1: "..matching*val)
			goto part2
		end
	end
end

::part2::

while true do
	local matching1=table.remove(values1,1)
	if not matching1 then return end
	local values2={table.unpack(values1)}
	while true do
		local matching2=table.remove(values2,1)
		if not matching2 then goto rep end
		for _,val in ipairs(values2) do
			if matching1+matching2+val==2020 then
				print("Part 2: "..matching1*matching2*val)
				return
			end
		end
	end
	::rep::
end