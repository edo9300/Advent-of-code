#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>
#include <cstring>

struct point {
	int X, Y;
};

class fabric {
public:
	int id;
	point distance, size;
	fabric(std::string input) {
		sscanf(input.c_str(), "#%d @ %d,%d: %dx%d", &id, &distance.X, &distance.Y, &size.X, &size.Y);
	}
};

int main() {
	std::ifstream input("input3.txt");
	std::string str;
	std::vector<fabric> inputs;
	std::map<int, bool> inputsids;
	point maxsize;
	while (std::getline(input, str)) {
		if (str.empty())
			continue;
		fabric tmpfabric(str);
		inputs.push_back(tmpfabric);
		inputsids[tmpfabric.id] = true;
		maxsize.X = std::max(tmpfabric.distance.X + tmpfabric.size.X, maxsize.X);
		maxsize.Y = std::max(tmpfabric.distance.Y + tmpfabric.size.Y, maxsize.Y);
	}
	input.close();
	int overlapping = 0;
	std::map<int, std::map< int, std::pair<int, int> >> total;
	for (auto& piece : inputs) {
		for (int i = piece.distance.X; i < piece.distance.X + piece.size.X; i++) {
			for (int j = piece.distance.Y; j < piece.distance.Y + piece.size.Y; j++) {
				total[i][j].first++;
				if (total[i][j].first == 2)
					overlapping++;
				if (total[i][j].second) {
					inputsids[total[i][j].second] = false;
					inputsids[piece.id] = false;
				} else {
					total[i][j].second = piece.id;
				}
			}
		}
	}
	std::cout << overlapping << std::endl;
	for (auto& id : inputsids) {
		if(id.second)
			std::cout << id.first << std::endl;
	}
	return 0;
}

