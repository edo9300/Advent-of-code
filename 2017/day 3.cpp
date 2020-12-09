#include <cmath>
#include <cstdio>

int part2(int count) {
	static int spiral[0x500][0x500] = {};
	spiral[0x280][0x280] = 1;
	int distance = 0;
	bool xaxis = false;
	int x = 0x280;
	int y = 0x280;
	int* incremented = &y;
	int increment = 1;
	for(int range = 1; spiral[x][y] < count;) {
		*incremented+=increment;
		if (++distance >= range) {
			distance=0;
			if(xaxis){
				range++;
				incremented = &y;
				increment *= -1;
			} else {
				incremented = &x;
			}
			xaxis = !xaxis;
		}
		spiral[x][y] = spiral[x + 1][y + 1] + spiral[x + 1][y] + spiral[x][y + 1] + spiral[x- 1][y - 1] + spiral[x][y - 1] + spiral[x - 1][y] + spiral[x + 1][y - 1] + spiral[x - 1][y + 1];
	}
	return spiral[x][y];
}

int main(int argc, char** argv){
	static int input = strtol(argv[1],NULL,10);
	int part1 = 0;
	int root = ceil(sqrt(input));
	if((root%2) != 0)
		root--;
	if(root > 0) {
		const int nextsquare = (root+1)*(root+1);
		const int previoussquare = (root-1)*(root-1);
		const int diffquarter=(nextsquare-previoussquare)/4;
		int mod=abs((diffquarter/2)-((input-previoussquare+(diffquarter-1)+1)%diffquarter));
		part1=mod+((root)/2);
	}
	printf("Part 1: %d\nPart 2: %d\n", part1, part2(input));
}
