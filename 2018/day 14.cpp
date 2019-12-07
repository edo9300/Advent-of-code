#include <iostream>
#include <algorithm>
#include <vector>

#define INPUT
#define INPUTSTR ""

int main() {
	std::string inputstr{ INPUTSTR };
	std::vector<int> input = [&inputstr]()->std::vector<int> {
		std::vector<int> input;
		for(auto& c : inputstr)
			input.push_back(c - '0');
		return input;
	}();
	std::vector<int> recipes{ 3,7 };
	struct {
		int recipe = 0;
		int current = 0;
	} elf1, elf2;
	elf1.recipe = 3;
	elf1.current = 0;
	elf2.recipe = 7;
	elf2.current = 1;
	while(recipes.size() < INPUT + 10) {
		int total = elf1.recipe + elf2.recipe;
		if(total >= 10) {
			recipes.push_back((int)std::floor(total / 10));
			recipes.push_back(total - ((int)std::floor(total / 10)*10));
		} else {
			recipes.push_back(total);
		}
		elf1.current = ((elf1.current + elf1.recipe + 1) % recipes.size());
		elf1.recipe = recipes[elf1.current];
		elf2.current = ((elf2.current + elf2.recipe + 1) % recipes.size());
		elf2.recipe = recipes[elf2.current];
	}
	std::cout << "part 1: ";
	for(int i = recipes.size() - 10; i < recipes.size(); i++) {
		std::cout << recipes[i];
	}
	std::cout << std::endl;
	volatile int counter = 0;
	auto recipes2 = recipes;
	while(std::search(recipes2.begin(), recipes2.end(), input.begin(), input.end()) == recipes2.end()) {
		counter += recipes.size();
		std::vector<int>(recipes2.begin() + recipes2.size() - 2 * input.size(), recipes2.end()).swap(recipes2);
		for(int i = 0; i < 10; i++) {
			int total = elf1.recipe + elf2.recipe;
			if(total >= 10) {
				recipes.push_back((int)std::floor(total / 10));
				recipes.push_back(total - ((int)std::floor(total / 10) * 10));
				recipes2.push_back((int)std::floor(total / 10));
				recipes2.push_back(total - ((int)std::floor(total / 10) * 10));
			} else {
				recipes.push_back(total);
				recipes2.push_back(total);
			}
			elf1.current = ((elf1.current + elf1.recipe + 1) % recipes.size());
			elf1.recipe = recipes[elf1.current];
			elf2.current = ((elf2.current + elf2.recipe + 1) % recipes.size());
			elf2.recipe = recipes[elf2.current];
		}
	}
	std::cout << "part2: " << std::distance(recipes.begin(), std::search(recipes.begin(), recipes.end(), input.begin(), input.end()));
	std::cout << std::endl;
	return 0;
}
