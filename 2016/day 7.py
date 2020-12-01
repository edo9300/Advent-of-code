import re
def chk1(st):
	regex1=r".*(\w)(?!\1)(\w)\2\1.*"
	regex2=r".*\[\w*(?:(\w)(?!\1)(\w))\2\1\w*\].*"
	return re.match(regex1,st,re.I) and not re.match(regex2,st,re.I)


def chk2(st):
	regex1=r".*(?P<g11>\w)(?!(?P=g11))(?P<g12>\w)(?P=g11)\w*(\[\w*\]\w*)*\[\w*(?P=g12)(?P=g11)\w*\].*"
	regex2=r".*\[\w*(?P<g21>\w)(?!(?P=g21))(?P<g22>\w)(?P=g21)\w*\]\w*(\[\w*\]\w*)*(?P=g22)(?P=g21)\w*.*"
	regex=r"(?:.*\[\w*(?P<g21>\w)(?!(?P=g21))(?P<g22>\w)(?P=g21)\w*\]\w*(\[\w*\]\w+)*(?P=g22)(?P=g21)\w*.*)|(?:.*(?P<g11>\w)(?!(?P=g11))(?P<g12>\w)(?P=g11)(\w+\[\w*\])*\[\w*(?P=g12)(?P=g11)\w*\].*)"
	return re.match(regex,st,re.I)
	
file=open("in7.txt","r",encoding="UTF-8")
count1=0
count2=0
for line in file:
	if chk1(line):
		count1+=1
	if chk2(line):
		count2+=1
print("Part 1:",count1)
print("Part 2:",count2)