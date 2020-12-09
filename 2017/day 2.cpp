#include <vector>
#include <string>
#include <fstream>
#include <sstream>

int main(){
	std::vector<std::vector<int>> table;
	std::ifstream input("in2.txt");
	std::string line;
	while(std::getline(input,line)) {
		std::istringstream tokenStream(std::move(line));
		std::vector<int> row;
		while(std::getline(tokenStream,line,'\t'))
			row.push_back(static_cast<int>(std::stol(line)));
		table.push_back(std::move(row));
	}
	int checksum1 = 0, checksum2 = 0;
	for(const auto& tab : table) {
		int min = INT32_MAX, max = 0;
		int res = 0;
		for(int j = 0; j < tab.size(); j++) {
			if(tab[j]<min)
				min = tab[j];
			if(tab[j]>max)
				max = tab[j];
			for(int k = 0; res == 0 && k < tab.size(); k++) {
				if(k != j) {
					if((tab[j] % tab[k]) == 0)
						res = tab[j] / tab[k];
				}
			}
		}
		checksum1 += (max - min);
		checksum2 += res;
	}
	printf("Part 1: %d\nPart 2: %d\n", checksum1, checksum2);
}
