#include <iostream>
#include <fstream>
#include <cstdint>
#include <map>
#include <set>
#include <algorithm>

struct sorter {
	bool sorter(const std::pair<char,uint32_t>& lhs, const std::pair<char,uint32_t>& rhs) const {
		return lhs.second>rhs.second || (lhs.second==rhs.second && lhs.first<rhs.first);
	}
};

std::string decipher(std::string str, size_t offset) {
	for(auto& c : str) {
		if(c=='-' || c==' ') {
			if(offset%2)
				c=(c=='-')?' ':'-';
		} else {
			c=(((c-'a')+offset)%26)+'a';
		}
	}
	return str;
}

int is_valid(const std::string& str, size_t& north_pole) {
	std::map<char,uint32_t> values;
	const auto pos=str.find('[');
	const auto last=str.find_last_of('-');
	const auto roomname=str.substr(0,last);
	const size_t sector = std::stoul(str.substr(str.find_last_of('-')+1,pos-last-1));
	if(decipher(roomname,sector%26)=="northpole-object-storage")
		north_pole=sector;
	for(const auto& c : roomname) {
		if(isalpha(c))
			values[c]+=1;
	}
	std::set<std::pair<char,uint32_t>,sorter> sorted{values.begin(),values.end()};
	const char* c = &str[pos+1];
	for(const auto& val : sorted){
		if(*c==']')
			break;
		if(val.first!=*c++){
			return 0;
		}
	}
	return sector;
}

int main() {
	std::ifstream input("in4.txt");
	std::string line;
	int sectortot=0;
	size_t pole=0;
	while(std::getline(input,line))
		sectortot+=is_valid(line,pole);
	std::cout<<"Part 1: "<<sectortot<<std::endl;
	std::cout<<"Part 2: "<<pole<<std::endl;
	return 0;
}