local part1,part2=0,0

local curanswer=nil
local curfullanswer=nil

function check()
	if curanswer then
		for _,_ in pairs(curfullanswer) do
			part1=part1+1
		end
		for _,_ in pairs(curanswer) do
			part2=part2+1
		end
	end
	curfullanswer=nil
	curanswer=nil
end

for line in io.open("in6.txt"):lines() do
	if line=="" then
		check()
	else
		if not curanswer then
			curfullanswer={}
			curanswer=curfullanswer
			for c in line:gmatch("(.)") do
				curfullanswer[c]=true
			end
		else
			local tmpanswers={}
			for c in line:gmatch("(.)") do
				tmpanswers[c]=curanswer[c]
				curfullanswer[c]=true
			end
			curanswer=tmpanswers
		end
	end
end
check()

print("Part 1: "..part1)
print("Part 2: "..part2)