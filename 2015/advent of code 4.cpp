#include <iostream>
#include <string>
#define MD5INCLUDE
#include MD5INCLUDE
#define MD5FUNCTION(x)

#define INPUT

int main() {
	std::string input(INPUT);
	std::string res;
	/*PART 1*/
	int i = 0;
	while (res.size()<5 || res.substr(0,5) != "00000") {
		res = MD5FUNCTION(input+std::to_string(++i));
	}
	std::cout << i << std::endl;
	/*PART 2*/
	i = 0;
	while (res.size()<5 || res.substr(0,6) != "000000") {
		res = MD5FUNCTION(input+std::to_string(++i));
	}
	std::cout << i << std::endl;
	return 0;
}
