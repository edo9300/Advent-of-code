local chars={}
for line in io.open("in6.txt"):lines() do
	local idx=1
	for ch in line:gmatch("(.)") do
		if not chars[idx] then chars[idx]={} end
		if not chars[idx][ch] then chars[idx][ch]=1 else
		chars[idx][ch]=chars[idx][ch]+1 end
		idx=idx+1
	end
end

local final1={}
local final2={}

for _,i in ipairs(chars) do
	local maxch
	local minch
	for ch,val in pairs(i) do
		if maxch==nil or maxch[2]<val then
			maxch={ch,val}
		end
		if minch==nil or minch[2]>val then
			minch={ch,val}
		end
	end
	table.insert(final1,maxch[1])
	table.insert(final2,minch[1])
end

print("Part 1: "..table.concat(final1,""))
print("Part 2: "..table.concat(final2,""))