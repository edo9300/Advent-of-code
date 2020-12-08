local md5 = require 'md5'
local input=""

local curid=0
local found=0
local found2=0
local founds={}
local founds2={}
repeat
	local hex=md5.sumhexa(input..curid)
	if hex:sub(1,5)=="00000" then
		local ch6=hex:sub(6,6)
		if found<8 then
			table.insert(founds,ch6)
			found=found+1
		end
		ch6=tonumber(ch6)
		if ch6 and ch6<8 and not founds2[ch6+1] then
			founds2[ch6+1]=hex:sub(7,7)
			found2=found2+1
		end
	end
	curid=curid+1
until found2==8

print("Part 1: "..table.concat(founds,""))
print("Part 2: "..table.concat(founds2,""))