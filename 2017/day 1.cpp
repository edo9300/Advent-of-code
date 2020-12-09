#include <fstream>
#include <string>

int main() {
	std::ifstream inputf("in2.txt");
    inputf.seekg(0, std::ifstream::end);
    const int length = inputf.tellg();
    inputf.seekg(0, std::ifstream::beg);
	std::string str;
	str.resize(length);
	inputf.read(&str[0],length);
	int total1 = 0, total2 = 0;
	auto check=[&str,&length](int index, int jmp) {
		const int otherindex=(index+jmp) % length;
		const char curchar=str[index];
		return (curchar == str[otherindex]) ? curchar - '0' : 0;
	};
	for (int index = 0; index < str.length(); ++index) {
		total1 += check(index, 1);
		total2 += check(index, length/2);
	}
	printf("Part 1: %d\nPart 2: %d\n", total1, total2);
}
