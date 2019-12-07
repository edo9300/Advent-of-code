#include <iostream>
#include <fstream>
#include <string>  
#include <algorithm>
#include <vector>

int compare(const std::string& first, const std::string& second){
	if(first.size() != second.size())
		return -1;
	int res = -1;
	for(size_t i = 0; i < first.size(); i++){
		if(first[i] != second[i]){
			if(res != -1)
				return -1;
			res = i;
		}
	}
	return res;
}

int main() {
	std::ifstream input("input2.txt");
	std::string str;
	std::vector<std::string> inputs;
	while(std::getline(input, str)) {
		if(str.empty())
			continue;
		inputs.push_back(str);
	}
	input.close();
	/*int check1=0, check2=0;
	for(auto string : inputs) {
		std::sort(string.begin(), string.end());
		bool found2=false, found3=false;
		while(string.size() > 1 && !(found2 && found3)) {
			auto found = string.find_last_of(string[0]);
			if(found == 1 && !found2)
				found2 = true;
			if(found == 2 && !found3)
				found3 = true;
			string = string.substr(found + 1);
		}
		if (found2)
			check1++;
		if (found3)
			check2++;
	}
	std::cout<<check1*check2;*/
	std::string result_string = "";
	for(size_t i = 0; i < inputs.size(); i++) {
		for(size_t j = i + 1; j < inputs.size(); j++) {			
			int res = compare(inputs[i], inputs[j]);
			if(res != -1){
				result_string = inputs[i].substr(0, res) + inputs[i].substr(res + 1);
				break;
			}
		}	
	}
	
	if(result_string.size()){
		std::cout<<result_string;
	} else {
		std::cout<<"no answer";
	}
	
	return 0;
}
