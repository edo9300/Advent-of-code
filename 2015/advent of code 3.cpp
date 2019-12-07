#include <iostream>
#include <stdlib.h>

#define PART2

using namespace std;

class House{
	bool visited = false;
	int presents;
	public:
	bool visit();
	int presents_count();
	
};

bool House::visit(){
	presents++;
	if(visited)
		return false;
	visited = true;
	return true;
}

House city[0x2000][0x2000];

int main(){
	int x=0x1000,y=0x1000, total=1;
	FILE* fp=fopen("input 3.txt","r");
	char inputbuff[0x2000];
	fgets(inputbuff,0x2000,fp);
	fclose(fp);
	string input(inputbuff);
	city[x][y].visit();
	#ifdef PART2
	for(int i=0; i < input.length(); i+=2){
	#else
	for(int i=0; i < input.length(); i++){
	#endif
		switch(input[i]){
			case '^':{
				y++;
				if(city[x][y].visit())
					total++;
				break;
			}
			case 'v':{
				y--;
				if(city[x][y].visit())
					total++;
				break;
			}
			case '>':{
				x++;
				if(city[x][y].visit())
					total++;
				break;
			}
			case '<':{
				x--;
				if(city[x][y].visit())
					total++;
				break;
			}
		}
	}
	#ifdef PART2
	x=0x1000,y=0x1000;
	for(int i=1; i < input.length(); i+=2){
		switch(input[i]){
			case '^':{
				y++;
				if(city[x][y].visit())
					total++;
				break;
			}
			case 'v':{
				y--;
				if(city[x][y].visit())
					total++;
				break;
			}
			case '>':{
				x++;
				if(city[x][y].visit())
					total++;
				break;
			}
			case '<':{
				x--;
				if(city[x][y].visit())
					total++;
				break;
			}
		}
	}
	#endif
	cout<<total;
	
	
	
}
