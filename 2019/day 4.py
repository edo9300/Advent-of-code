start=
stop=

counter=0
counter2=0
for i in range(start,stop+1):
	st=str(i)
	prev=chr(0)
	prev2=chr(0)
	double=False
	doubleforsure=False
	double1=False
	for c in st:
		if prev>c:
			double=False
			doubleforsure=False
			double1=False
			break
		if prev==c:
			double=True
			double1=True
		elif double:
			doubleforsure=True
		if prev==prev2==c:
			double=False
		prev2=prev
		prev=c
	if double1:
		counter+=1
	if doubleforsure or double:
		counter2+=1
print(counter)
print(counter2)