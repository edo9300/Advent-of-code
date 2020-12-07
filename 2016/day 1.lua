input=io.open("in1.txt"):lines()()

local x,y=0,0
local dir=1
local dirs={ "north", "east", "south", "west" }
checkvisited=(function()
	local visited={}
	local res=nil
	return function()
		if res then return res end
		if not visited[x] then visited[x]={} end
		if visited[x][y] then
			res=math.abs(x)+math.abs(y)
			return
		end
		visited[x][y]=true
	end
end)()

function changedir(turn)
	if turn=="L" then
		dir=((dir)%4)+1
	elseif turn=="R" then
		dir=((dir+2)%4)+1
	end
end

function move(amt)
	local curdir=dirs[dir]
	if curdir=="north" then
		for i=1,amt do
			y=y-1
			checkvisited()
		end
	elseif curdir=="east" then
		for i=1,amt do
			x=x-1
			checkvisited()
		end
	elseif curdir=="south" then
		for i=1,amt do
			y=y+1
			checkvisited()
		end
	elseif curdir=="west" then
		for i=1,amt do
			x=x+1
			checkvisited()
		end
	end
end

checkvisited()
for turn,amt in input:gmatch("([%a]+)([%d]+)") do
	changedir(turn)
	move(tonumber(amt))
end

print("Part 1: "..(math.abs(x)+math.abs(y)))
print("Part 2: "..checkvisited())