#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include <algorithm>

std::string React(std::string polymer) {
	for (int i = 0; i < polymer.size(); i++) {
		if (i >= polymer.size()) {
			if (i > polymer.size() + 1)
				break;
		}
		if (i > 0) {
			if (abs(polymer[i] - polymer[i - 1]) == 32) {
				polymer.erase(polymer.begin() + i - 1, polymer.begin() + i + 1);
				i -= 2;
			}
		}
	}
	return polymer;
}

int main() {
	std::ifstream input("input5.txt");
	std::string polymer;
	std::getline(input, polymer);
	input.close();
	int minsize = (polymer = React(polymer)).size();
	std::cout<< "the first answer is: "<< minsize << std::endl;
	for (int i = 0; i < 26; i++) {
		std::string polymercopy = polymer;
		polymercopy.erase(std::remove(polymercopy.begin(), polymercopy.end(), 'a' + i), polymercopy.end());
		polymercopy.erase(std::remove(polymercopy.begin(), polymercopy.end(), 'A' + i), polymercopy.end());
		minsize = std::min(minsize, (int)React(polymercopy).size());
	}
	std::cout << "the second answer is: " << minsize << std::endl;
    return 0;
}

