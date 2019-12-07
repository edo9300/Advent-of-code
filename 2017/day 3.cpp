#include <iostream>
#include <cmath>

#define PART2

using namespace std;


int spiral[0x2000][0x2000] = {0};

int spiralMatrix(int x, int y, int step, int count){ //modified version of https://stackoverflow.com/a/46852039
    int distance = 0;
    int range = 1;
    int direction = 0;
    int total = 1;
	int i;
	#ifdef PART2
    for (i = 0; total < count; i++ ) {
    #else
    for (i = 0; i < count; i++ ) {
    #endif
        distance++;
        switch (direction) {
            case 0:
                y += step;
                if ( distance >= range ) {
                    direction = 1;
                    distance = 0;
                }
                break;
            case 1:
                x += step;
                if (distance >= range) {
                    direction = 2;
                    distance = 0;
                    range += 1;
                }
                break;
            case 2:
                y -= step;
                if (distance >= range) {
                    direction = 3;
                    distance = 0;
                }
                break;
            case 3:
                x -= step;
                if (distance >= range) {
                    direction = 0;
                    distance = 0;
                    range += 1;
                }
                break;
        }
        spiral[x][y] = spiral[x + 1][y + 1] + spiral[x + 1][y] + spiral[x][y + 1] + spiral[x- 1][y - 1] + spiral[x][y - 1] + spiral[x - 1][y] + spiral[x + 1][y - 1] + spiral[x - 1][y + 1];
        total = spiral[x][y];
    }
	#ifdef PART2
    return total;
    #else
    return abs(x - 0x1000) + abs(y - 0x1000) - 1;
    #endif
}

int main(){
	int input = 289326;
	spiral[0x1000][0x1000] = 1;
	cout<<spiralMatrix(0x1000,0x1000,1,input);
}
