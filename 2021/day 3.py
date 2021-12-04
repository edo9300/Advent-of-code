import math
with open("in3.txt") as f:
    ints=[int(i,2) for i in f.readlines()]
    half=len(ints)//2
    max_elem=max(ints)
    gamma=0
    epsilon=0
    for flag in [1<<val for val in range(0, int(math.log(max_elem,2)+1))]:
        if len([1 for v in ints if v & flag == flag])>half:
            gamma=gamma|flag
        else:
            epsilon=epsilon|flag
    print(gamma*epsilon)