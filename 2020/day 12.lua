local dirs={ "N", "E", "S", "W" }
local part1=(function()
	local x,y=0,0
	getpart1=function()
		return math.abs(x)+math.abs(y)
	end
	local dir=2
	function move(curdir,amt)
		if curdir=="N" then
			y=y-amt
		elseif curdir=="E" then
			x=x-amt
		elseif curdir=="S" then
			y=y+amt
		elseif curdir=="W" then
			x=x+amt
		end
	end
	function changedir(turn,degree)
		degree=degree/90
		if turn=="L" then
			dir=((dir-degree+3)%4)+1
			return true
		elseif turn=="R" then
			dir=((dir+degree-1)%4)+1
			return true
		end
		return turn=="F"
	end
	return function(_dir,val)
		local curdir=changedir(_dir,val) and dirs[dir] or _dir
		if _dir~="L" and _dir~="R" then
			move(curdir,val)
		end
	end
end)()

local part2=(function()
	local x,y=0,0
	local waypointx,waypointy=10,1
	getpart2=function()
		return math.abs(x)+math.abs(y)
	end
	function movewaypoint(dir,amt)
		if dir=="N" then
			waypointy=waypointy+amt
		elseif dir=="E" then
			waypointx=waypointx+amt
		elseif dir=="S" then
			waypointy=waypointy-amt
		elseif dir=="W" then
			waypointx=waypointx-amt
		end
	end
	function movetowaypoint(amt)
		local absx,absy=(x-waypointx)*amt,(y-waypointy)*amt
		x=x+absx
		waypointx=waypointx+absx
		y=y+absy
		waypointy=waypointy+absy
	end
	function rotatewaypoint(turn,degree)
		local clockwise=turn=="R"
		waypointx=waypointx-x
		waypointy=waypointy-y
		for i=1,math.abs(degree/90) do
			if clockwise then
				local tmpx=waypointx
				waypointx=waypointy
				waypointy=-tmpx
			else
				local tmpy=waypointy
				waypointy=waypointx
				waypointx=-tmpy
			end
		end
		waypointx,waypointy=waypointx+x,waypointy+y
	end
	return function(dir,val)
		if dir=="F" then
			movetowaypoint(val)
		elseif dir=="L" or dir=="R" then
			rotatewaypoint(dir,val)
		else
			movewaypoint(dir,val)
		end
	end
end)()

for line in io.open("in12.txt"):lines() do
	local dir,val=line:match("(%a)(%d*)")
	val=tonumber(val)
	part1(dir,val)
	part2(dir,val)
end
print("Part 1: "..getpart1())
print("Part 2: "..getpart2())