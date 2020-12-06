local part1,part2=0,0
local seats={}

for line in io.open("in5.txt"):lines() do
	local rangelow,rangehigh=0,127
	local columnlow,columnhigh=0,7
	for c in line:gmatch("(.)") do
		if c=="F" then
			rangehigh=rangelow+(rangehigh-rangelow)//2
		elseif c=="B" then
			rangelow=rangehigh-(rangehigh-rangelow)//2
		elseif c=="L" then
			columnhigh=columnlow+(columnhigh-columnlow)//2
		elseif c=="R" then
			columnlow=columnhigh-(columnhigh-columnlow)//2
		end
	end
	local seatid=rangelow*8+columnlow
	seats[seatid]=true
	part1=math.max(part1,seatid)
end

local prev=0
for seat,_ in pairs(seats) do
	if seat-prev==2 then
		part2=seat-1
		break
	end
	prev=seat
end

print("Part 1: "..part1)
print("Part 2: "..part2)