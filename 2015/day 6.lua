input=io.open("in6.txt")
if input then
	local grid={}
	local grid2={}
	for line in input.lines(input) do
		if string.find(line, "toggle") then
			func=function(cell)return not cell end
			func2=function(cell)return cell and cell+2 or 2 end
			startx,starty,stopx,stopy = string.match(line, "toggle (%d+),(%d+) through (%d+),(%d+)")
		elseif string.find(line, "turn off") then
			func=function(cell)return false end
			func2=function(cell)return cell and cell >0 and cell-1 or 0  end
			startx,starty,stopx,stopy = string.match(line, "turn off (%d+),(%d+) through (%d+),(%d+)")
		elseif string.find(line, "turn on") then
			func=function(cell)return true end
			func2=function(cell)return cell and cell+1 or 1 end
			startx,starty,stopx,stopy = string.match(line, "turn on (%d+),(%d+) through (%d+),(%d+)")
		end
		startx=tonumber(startx)
		starty=tonumber(starty)
		stopx=tonumber(stopx)
		stopy=tonumber(stopy)
		for x=startx,stopx do
			for y=starty,stopy do
				grid[x+y*1000]=func(grid[x+y*1000])
				grid2[x+y*1000]=func2(grid2[x+y*1000])
			end
		end
	end
	tot=0
	tot2=0
	for i=0,999999 do
		if grid[i] then
			tot=tot+1
		end
		if grid2[i] then
			tot2=tot2+grid2[i]
		end
	end
	print("Part 1: "..tot)
	print("Part 2: "..tot2)
end