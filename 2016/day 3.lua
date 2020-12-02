input=io.open("in3.txt")

col={}

function checktriangle(s1,s2,s3)
	return (s1+s2)>s3 and (s1+s3)>s2 and (s3+s2)>s1
end

if input then
	local total=0
	local i=0
	for line in input:lines() do
		local s1,s2,s3 = string.match(line, "%s*(%d+)%s+(%d+)%s+(%d+)")
		s1=tonumber(s1)
		s2=tonumber(s2)
		s3=tonumber(s3)
		local length=i%3+((i//3)*9)
		col[length+1]=s1
		col[length+4]=s2
		col[length+7]=s3
		if checktriangle(s1,s2,s3) then
			total=total+1
		end
		i=i+1
	end
	print("Part 1: "..total)
	total=0
	for j=0,#col//3-1 do
		local s1,s2,s3 = table.unpack(col, 1+(j*3), (j*3)+3)
		if checktriangle(s1,s2,s3) then
			total=total+1
		end
	end
	print("Part 2: "..total)
end