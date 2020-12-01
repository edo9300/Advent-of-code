input=io.open("in9.txt")

cities={}
totcities={}

function setdest(city,dest,dist)
	if not cities[city] then cities[city]={} totcities[city]=true end
	if not cities[dest] then cities[dest]={} totcities[dest]=true end
	cities[city][dest]=dist
	cities[dest][city]=dist
end

function tracepath(to_search,prev)
	local minimum=nil
	local maximum=nil
	for key,value in pairs(to_search) do
		to_search[key]=nil
		local res=((not prev) and 0 or cities[prev][key])
		local short,long=tracepath(to_search,key)
		to_search[key]=true
		minimum=(not minimum or (res+short)<minimum) and (res+short) or minimum
		maximum=(not maximum or (res+long)>maximum) and (res+long) or maximum
	end
	return minimum or 0,maximum or 0
end

if input then
	for line in input.lines(input) do
		local start,dest,dist = string.match(line, "(%S+) to (%S+) = (%d+)")
		setdest(start,dest,tonumber(dist))
	end
	local short,long=tracepath(totcities)
	print("Part 1: "..short)
	print("Part 2: "..long)
end