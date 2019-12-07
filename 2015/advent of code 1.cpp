#include <iostream>

#define PART 2

using namespace std;


int main(){
	FILE* fp=fopen("input 1.txt","r");
	char inputbuff[0x2000];
	fgets(inputbuff,0x2000,fp);
	fclose(fp);
	string input(inputbuff);
	int floor = 0;
	for(int i=0; i < input.length(); i++){
		if (input[i] == '(')
			floor ++;
		else if (input[i] == ')')
			floor--;
		if(PART == 2){
			if(floor==-1){
				floor=i+1;
				break;
			}
		}
	}
	cout<<floor;
	
}
