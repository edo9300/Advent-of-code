input=io.open("in8.txt")

function countescaped(str)
	local escaping=false
	local hex1=false
	local hex2=false
	local tot=0
	for c in string.gmatch(str:sub(2,-2),".") do
		if not escaping and c=="\\" then
			escaping=true
		else
			if escaping and c=="x" then
				hex1=true
				hex2=true
			else
				if hex1 then
					hex1=false
				elseif hex2 then
					hex2=false
					escaping=false
					tot=tot+1
				else
					escaping=false
					tot=tot+1
				end
			end
		end
	end
	return tot
end

function escapecount(str)
	local escaping=false
	local hex1=false
	local hex2=false
	local tot=2
	for c in string.gmatch(str,".") do
		if c=="\\" or c=="\"" then tot=tot+1 end
		tot=tot+1
	end
	return tot
end

if input then
	local tot=0
	local tot2=0
	for line in input.lines(input) do
		tot=tot+#line-countescaped(line)
		tot2=tot2+escapecount(line)-#line
	end
	print("Part 1:"..tot)
	print("Part 2:"..tot2)
end