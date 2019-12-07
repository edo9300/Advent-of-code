#include <fstream>
#include <map>
#include <string>
#include <iostream>
#include <cstdint>

std::map<int64_t, uint8_t> ParsePlants(std::ifstream& file) {
	std::map<int64_t, uint8_t> res;
	std::string str;
	std::getline(file, str);
	for(size_t i = 0; i < str.size(); i++) {
		if(str[i] == '#') {
			res[i] = 1;
		}
	}
	return res;
}
inline uint8_t IsPlant(const char chr) {
	return (chr == '#') ? 1 : 0;
}
#define GET(idx)IsPlant(str[idx])<<4-idx
std::map<int64_t, uint8_t> ParseRules(std::ifstream& file) {
	std::map<int64_t, uint8_t> res;
	std::string str;
	while(std::getline(file, str)) {
		for(size_t i = 0; i < str.size(); i++) {
			int val = GET(0) | GET(1) | GET(2) | GET(3) | GET(4);
			res[val] = IsPlant(str[9]);
		}
	}
	return res;
}
#undef GET
int GetPlants(int idx, int offset, std::map<int64_t, uint8_t>& plants) {
	if(plants.count(idx)) {
		return plants[idx] << offset;
	}
	return 0;
}

#define GP(index,offset)	GetPlants(index, offset, plants)
int GetValue(int idx, std::map<int64_t, uint8_t>& plants) {
	return GP(idx - 2, 4) | GP(idx - 1, 3) | GP(idx, 2) + GP(idx + 1, 1) | GP(idx + 2, 0);
}
#undef GP

std::map<int64_t, uint8_t> Normalize(const std::map<int64_t, uint8_t>& map) {
	std::map<int64_t, uint8_t> res;
	int offset = map.begin()->first;
	for(const auto& item : map) {
		res[item.first - offset] = item.second;
	}
	return res;
}

std::map<int64_t, uint8_t> Increase(const std::map<int64_t, uint8_t>& map, int64_t amount) {
	std::map<int64_t, uint8_t> res;
	int offset = map.begin()->first;
	for(const auto& item : map) {
		res[item.first + amount] = item.second;
	}
	return res;
}

int main() {
	std::ifstream input("input12.txt");
	auto plants = ParsePlants(input);
	std::string str;
	std::getline(input, str);
	auto rules = ParseRules(input);
	input.close();
	std::map<int, std::map<int64_t, uint8_t>> old;
	int i = 0;
	std::map<int64_t, uint8_t> nplants;
	for(; i < 100; i++) {
		nplants.clear();
		for(auto& pot : plants) {
			for(int j = pot.first - 2; j < pot.first + 2; j++) {
				auto value = rules[GetValue(j, plants)];
				if(value)
					nplants[j] = 1;
			}
		}
		if(plants.size() == nplants.size() && Normalize(plants) == Normalize(nplants))
			break;
		plants = nplants;
		old[i] = plants;
	}
	int64_t total = 0;
	for(auto& plant : old[19]) {
		total += plant.first;
	}
	std::cout << "part 1:" << total << std::endl;
	total = 0;
	plants = Increase(plants, 50000000000 - i);
	for(auto& plant : plants) {
		total += plant.first;
	}
	std::cout << "part 2:" << total;
	return 0;
}