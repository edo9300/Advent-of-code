import re
with open("in2.txt") as f:
    horizontal1=0
    depth1=0
    horizontal2=0
    depth2=0
    aim=0
    for instruction in f.readlines():
        instr,value=instruction.split(" ")
        value=int(value)
        if instr=="forward":
            horizontal1+=value
            horizontal2+=value
            depth2+=aim*value

        if instr=="down":
            depth1+=value
            aim+=value

        if instr=="up":
            depth1-=value
            aim-=value

    print(horizontal1*depth1)
    print(horizontal2*depth2)