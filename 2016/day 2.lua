input=io.open("in2.txt")
local grid1={}
for i=1,3 do
	grid1[i]={}
	for j=1,3 do
		grid1[i][j]=i+3*(j-1)
	end
end
local grid2={}

for i=1,5 do
	grid2[i]={}
end
grid2[3][1]=1
grid2[2][2]=2
grid2[3][2]=3
grid2[4][2]=4
grid2[1][3]=5
grid2[2][3]=6
grid2[3][3]=7
grid2[4][3]=8
grid2[5][3]=9
grid2[2][4]="A"
grid2[3][4]="B"
grid2[4][4]="C"
grid2[3][5]="D"

function checkgrid(grid,x,y)
	return grid[x] and grid[x][y]
end

local x1,y1=2,2
local x2,y2=1,3
result1={}
result2={}
if input then
	for line in input:lines() do
		for c in line:gmatch(".") do
			if c == "U" then
				if checkgrid(grid1,x1,y1-1) then y1=y1-1 end
				if checkgrid(grid2,x2,y2-1) then y2=y2-1 end
			end
			if c == "D" then
				if checkgrid(grid1,x1,y1+1) then y1=y1+1 end
				if checkgrid(grid2,x2,y2+1) then y2=y2+1 end
			end
			if c == "R" then
				if checkgrid(grid1,x1+1,y1) then x1=x1+1 end
				if checkgrid(grid2,x2+1,y2) then x2=x2+1 end
			end
			if c == "L" then
				if checkgrid(grid1,x1-1,y1) then x1=x1-1 end
				if checkgrid(grid2,x2-1,y2) then x2=x2-1 end
			end
		end
		table.insert(result1,grid1[x1][y1])
		table.insert(result2,grid2[x2][y2])
	end
	print("Part 1: "..table.concat(result1, ""))
	print("Part 2: "..table.concat(result2, ""))
end