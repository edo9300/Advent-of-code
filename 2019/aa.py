from intcode import *
inp = [int(ins) for ins in open("in11").read().split(",")]
 
def part1():
    grid = {}
    machine = Machine([j for j in inp])
    robot = (0,0)
    robot_direction = 0
    color = 0
    output_type = 0
    directions = {0: (0,1), 1: (1,0), 2: (0,-1), 3: (-1,0)}
    while True:
        try:
            if output_type == 0:
                machine.run_machine([color])
            else:
                machine.run_machine([])
        except Output as e:
            if output_type == 0:
                grid[robot] = e.output
                output_type = 1
            elif output_type == 1:
                if e.output == 0:
                    robot_direction = (robot_direction - 1) % 4
                if e.output == 1:
                    robot_direction = (robot_direction + 1) % 4
                robot = (robot[0] + directions[robot_direction][0], robot[1] + directions[robot_direction][1])
                if robot in grid:
                    color = grid[robot]
                else:
                    color = 0
                output_type = 0
        except Interrupt:
            break
 
    return len(grid.keys())
 
 
def part2():
    grid = {}
    machine = Machine([j for j in inp])
    robot = (0,0)
    robot_direction = 0
    color = 1
    output_type = 0
    directions = {0: (0,1), 1: (1,0), 2: (0,-1), 3: (-1,0)}
    while True:
        try:
            if output_type == 0:
                machine.run_machine([color])
            else:
                machine.run_machine([])
        except Output as e:
            if output_type == 0:
                grid[robot] = e.output
                output_type = 1
            elif output_type == 1:
                if e.output == 0:
                    robot_direction = (robot_direction - 1) % 4
                if e.output == 1:
                    robot_direction = (robot_direction + 1) % 4
                robot = (robot[0] + directions[robot_direction][0], robot[1] + directions[robot_direction][1])
                if robot in grid:
                    color = grid[robot]
                else:
                    color = 0
                output_type = 0
        except Interrupt:
            break
    
    miny = 0
    minx = 0
    maxy = 0
    maxx = 0
    for cord in grid:
        if cord[0] < minx:
            minx = cord[0]
        if cord[0] > maxx:
            maxx = cord[0]
        if cord[1] < miny:
            miny = cord[1]
        if cord[1] > maxy:
            maxy = cord[1]
    print(miny)
    print(minx)
    print(maxy)
    print(maxx)
    # print(grid)
    painted = [[' ' for _ in range(maxx-minx + 1)] for _ in range(maxy-miny + 1)]
    for cord in grid:
        painted[cord[1]-miny][cord[0]-minx] = '█' if grid[cord] == 1 else ' '
 
    painted.reverse()
    for row in painted:
        print(''.join(row))
    
    
# print (part1())
print (part2())