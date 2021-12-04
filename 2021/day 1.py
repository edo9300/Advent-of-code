import sys
with open("in1.txt") as f:
    prev=sys.maxint
    count1=0
    lines=[int(i) for i in f.readlines()]
    for num in lines:
        if num>prev:
            count1+=1
        prev=num
    count2=0
    prev=sys.maxint
    for num in [sum(lines[n:n+3]) for n in range(0, len(lines)-2)]:
        if num>prev:
            count2+=1
        prev=num
    print(count1)
    print(count2)