local part1,part2=0,0

local bags={}

for line in io.open("in7.txt"):lines() do
	local bagcolor,extra=line:match("(%a+ %a+) bags contain(.+)%.")
	if bagcolor then
		bags[bagcolor]={}
		local curtable=bags[bagcolor]
		for rule in extra:gmatch(" ([^,]*)") do
			local amount,rulecolor=rule:match("(%d+) (%a+ %a+)")
			if amount then
				curtable[rulecolor]=tonumber(amount)
			end
		end
	end
end
function part1fun(color)
	local function findrecurse(bag)
		if not bag then return false end
		if bag[color] then return true end
		for _color,_bag in pairs(bag) do
			if findrecurse(bags[_color]) then return true end
		end
		return false
	end
	for _color,bag in pairs(bags) do
		if _color~=color then
			if bag[color] or findrecurse(bag) then
				part1=part1+1
			end
		end
	end
end
function part2fun(bag)
	local tot=1
	for color,amount in pairs(bag) do
		tot=tot+amount*part2fun(bags[color])
	end
	return tot
end

part1fun("shiny gold")
part2=part2fun(bags["shiny gold"])-1

print("Part 1: "..part1)
print("Part 2: "..part2)