import re

def CheckPart1(str):
	regex=r"^.*([\w])\1.*$"
	return re.match(regex,str,re.I) and ((str.count("a") + str.count("e") + str.count("i") + str.count("o") + str.count("u"))>=3)\
	and ((str.count("ab") + str.count("cd") + str.count("pq") + str.count("xy"))==0)

def CheckPart2(str):
	regex1=r"^.*([\w][\w]).*\1.*$"
	regex2=r'^.*([\w])(?!\1).\1.*$'
	return re.match(regex1,str,re.I) and re.match(regex2,str,re.I)

file=open("input 5.txt","r",encoding="UTF-8")
count1=0
count2=0
for line in file:
	if CheckPart1(line.strip()):
		count1+=1
	if CheckPart2(line.strip()):
		count2+=1
print("part 1",count1)
print("part 2",count2)