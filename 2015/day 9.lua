input=io.open("in9.txt")

cities={}
totcities={}

function setdest(city,dest,dist)
	if not cities[city] then cities[city]={} totcities[city]=true end
	if not cities[dest] then cities[dest]={} totcities[dest]=true end
	cities[city][dest]=dist
	cities[dest][city]=dist
end

function copytable(orig)
	local copy = {}
	for orig_key, orig_value in pairs(orig) do
		copy[orig_key] = orig_value
	end
    return copy
end

function findshortest(to_search,prev)
	local minimum=nil
	for key,value in pairs(to_search) do
		to_search[key]=nil
		local res=((not prev) and 0 or cities[prev][key])+findshortest(to_search,key)
		to_search[key]=true
		minimum=(not minimum or res<minimum) and res or minimum
	end
	return minimum or 0
end

function findlongest(to_search,prev)
	local maximum=nil
	local iterated=false
	for key,value in pairs(to_search) do
		iterated=true
		to_search[key]=nil
		local res=((not prev) and 0 or cities[prev][key])+findlongest(to_search,key)
		to_search[key]=true
		maximum=(not maximum or res>maximum) and res or maximum
	end
	return maximum or 0
end

if input then
	for line in input.lines(input) do
		local start,dest,dist = string.match(line, "(%S+) to (%S+) = (%d+)")
		setdest(start,dest,tonumber(dist))
	end
	print("Part 1: "..findshortest(totcities))
	print("Part 2: "..findlongest(totcities))
end