#include <iostream>
#include <fstream>
#include <string>  
#include <set>
#include <vector>

int main() {
	std::ifstream input("input1.txt");
	std::string str;
	std::vector<int> inputs;
	while(std::getline(input, str)) {
		if(str.empty())
			continue;
		inputs.push_back(std::stoi(str));
	}
	input.close();
	int res = 0;
	for(auto number : inputs) {
		res+=number;
	}
	std::cout<<"the final frequence is: "<<res<<std::endl;
	std::set<int> twice = {0};
	res = 0;
	for(auto i = 0; i < inputs.size(); i = (i+1)%inputs.size()) {
		res+=inputs[i];
		if(!twice.insert(res).second)
			break;
	}
	std::cout<<"the frequence repeated twice is: "<<res<<std::endl;
	return 0;
}
