checkslope=(function()
	local grid={}
	local totalx=nil
	for line in io.open("in3.txt"):lines() do
		local row={}
		for c in line:gmatch(".") do
			table.insert(row,c)
		end
		if not totalx then totalx=#row end
		table.insert(grid,row)
	end
	local totaly=#grid
	return function(incx,incy)
		local trees=0
		local x,y=1,1
		while y<=totaly do
			if grid[y][x]=="#" then
				trees=trees+1
			end
			y=(y+incy)
			x=((x-1+incx)%totalx)+1
		end
		return trees
	end
end)()

print("Part 1: "..checkslope(3,1))
print("Part 2: "..(checkslope(1,1)*checkslope(3,1)*checkslope(5,1)*checkslope(7,1)*checkslope(1,2)))