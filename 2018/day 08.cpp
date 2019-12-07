#include <iostream>
#include <fstream>
#include <string>
#include <vector>

class node {
public:
	struct header {
		int number_childs;
		int number_entries;
	};
	header _header;
	std::vector<node> childs;
	std::vector<int> entries;
	node() :_header({ 0,0 }) {};
	node(std::string& input) {
		Format(input);
	};
	void Format(std::string& input) {
		ReadHeader(input);
		for (int i = 0; i < _header.number_childs; i++) {
			childs.push_back(node(input));
		}
		for (int i = 0; i < _header.number_entries; i++) {
			entries.push_back(GetNumber(input));
		}
	};
	void ReadHeader(std::string& input) {
		_header.number_childs = GetNumber(input);
		_header.number_entries = GetNumber(input);
	}
	int GetNumber(std::string& input) {
		auto pos = input.find(" ");
		if (pos == std::string::npos) {
			int res = std::stoi(input);
			input.erase();
			return res;
		}
		int res = std::stoi(input.substr(0, pos));
		input.erase(input.begin(), input.begin() + pos + 1);
		return res;
	}
	int GetMetadataSum() {
		int res = 0;
		for (auto& child : childs)
			res += child.GetMetadataSum();
		for (auto& value : entries)
			res += value;
		return res;
	}
	int GetRootValueSum() {
		int res = 0;
		if (!_header.number_childs) {
			for (auto& value : entries)
				res += value;
		} else {
			for (auto& value : entries) {
				if((value - 1) < _header.number_childs)
					res += childs[value - 1].GetRootValueSum();
			}

		}
		return res;
	}
};

int main() {
	std::ifstream input("input8.txt");
	std::string input_string;
	std::getline(input, input_string);
	input.close();
	node a;
	a.Format(input_string);
	std::cout << a.GetMetadataSum() << std::endl;
	std::cout << a.GetRootValueSum() << std::endl;
    return 0;
}