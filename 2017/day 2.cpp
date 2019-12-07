#include <iostream>
#include <vector>
#include <string.h>

#define PART2

using namespace std;

int main(){
	vector< vector<int> > table;
	FILE* fp = fopen("input2.txt", "r");
	char linebuf[0x2000];
	char* strbuf;
	int row=0, col=0;
	while(fgets(linebuf, 0x2000, fp)) {
		vector<int> row;
		strbuf = strtok(linebuf,"	");
		while (strbuf != NULL){
			int i;
			sscanf(strbuf, "%d",&i);
			row.push_back(i);
			strbuf = strtok (NULL, "	");
		}
		table.push_back(row);
	}
	fclose(fp);
	int checksum=0;
	#ifndef PART2
		for(int i=0; i < table.size(); i++){
			int min=0, max=0;
			for(int j =0; j < table[i].size(); j++){
				if(table[i][j])
					if(table[i][j]<min || min ==0)
						min = table[i][j];
					if(table[i][j]>max)
						max = table[i][j];    		
			}
			checksum += (max - min);
		}
	#else
		for(int i=0; i < table.size(); i++){			
			int res = 0;
			for(int j = 0; j < table[i].size(); j++)
				for(int k = 0; k < table[i].size(); k++)
					if(k != j){
						int division = table[i][j] / table[i][k];
						if((division * table[i][k]) == table[i][j])
							res = division;
					}
			checksum += res;
		}
	#endif
	cout<<checksum;
}
