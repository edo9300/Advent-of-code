#include <iostream>

#define PART 1

using namespace std;

int main(){
	FILE* fp = fopen("input1.txt", "r");
	char input[0x2000];
	fgets(input, 0x2000, fp);
	fclose(fp);
	string str(input);
	int total=0, jump = (PART == 1) ? 1 : str.length()/2;
	for (int index = 0; index < str.length(); ++index){
		if(str[index]==str[(index+jump) % str.length()])
		total += (str[index] - '0');
	}
	cout << total;
}
