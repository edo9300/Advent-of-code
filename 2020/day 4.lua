function fieldpresent(tab,field,...)
	return not field or (tab[field] and fieldpresent(tab,...))
end

fieldvalid=(function()
	local checkfunc={}
	checkfunc["byr"]=function(val)
		local num=tonumber(val)
		return num and num>=1920 and num<=2002
	end
	checkfunc["iyr"]=function(val)
		local num=tonumber(val)
		return num and num>=2010 and num<=2020
	end
	checkfunc["eyr"]=function(val)
		local num=tonumber(val)
		return num and num>=2020 and num<=2030
	end
	checkfunc["hgt"]=function(val)
		local hght,unit = val:match("(%d*)(%a*)")
		hght=tonumber(hght)
		return hght and ((unit=="cm" and hght>=150 and hght<=193) or (unit=="in" and hght>=59 and hght<=76))
	end
	checkfunc["hcl"]=function(val)
		local _val=val:match("#(%w*)")
		return _val and #_val==6 and (_val:match("([^%dabcdef])"))==nil
	end
	checkfunc["ecl"]=function(val)
		return val=="amb" or val=="blu" or val=="brn" or val=="gry" or val=="grn" or val=="hzl" or val=="oth"
	end
	checkfunc["pid"]=function(val)
		return tonumber(val) and #val==9
	end
	return function(tab,field,...)
		return not field or (checkfunc[field](tab[field]) and fieldvalid(tab,...))
	end
end)()

local total=0
local total2=0

local curpassport=nil

function check()
	if curpassport then
		if fieldpresent(curpassport,"byr","iyr","eyr","hgt","hcl","ecl","pid") then
			total=total+1
			if fieldvalid(curpassport,"byr","iyr","eyr","hgt","hcl","ecl","pid") then
				total2=total2+1
			end
		end
	end
end
for line in io.open("in4.txt"):lines() do
	if line=="" then
		check()
		curpassport=nil
	else
		if not curpassport then curpassport={} end
		for _val in line:gmatch("([^ ]*)") do
			local field,val=_val:match("([^:]*):([^:]*)")
			curpassport[field]=val
		end
	end
end
check()

print("Part 1: "..total)
print("Part 2: "..total2)