#include <iostream>
#include <string>
#include <algorithm>

#ifndef INPUT
int INPUT;
#endif // !INPUT

class point {
public:
	int X, Y, power_level;
	point() :X(0), Y(0) {};
	point(int x, int y) :X(x), Y(y) {CalculatePowerLevel();};
	void Set(int x, int y) {
		X = x;
		Y = y;
		CalculatePowerLevel();
	}
	void CalculatePowerLevel() {
		int rack_id = X + 10;
		int step2 = rack_id * Y;
		int step3 = step2 + INPUT;
		int step4 = step3 * rack_id;
		int step5 = (step4 % 1000 - step4 % 100) / 100;
		power_level = step5 - 5;
	}
};

point points[300 * 300];

int GetArea(int x, int y, int size = 3) {
	int return_area = 0;
	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++)
			return_area += points[(x + i) + 300 * (y + j)].power_level;
	}
	return return_area;
}

void Init() {
	for (int x = 0; x < 300; x++) {
		for (int y = 0; y < 300; y++) {
			points[x + 300 * y].Set(x, y);
		}
	}
}

int main() {
#ifndef INPUT
	std::cout << "Insert your input: ";
	std::cin >> INPUT;
#endif
	std::pair<int, std::pair<point, int>> max_area = std::make_pair(0, std::make_pair(point(0, 0), 0));
	std::pair<int, point> max_area_3x3 = std::make_pair(0, point(0, 0));
	Init();
	for (int x = 0; x < 300; x++) {
		std::cout << x << std::endl;
		for (int y = 0; y < 300; y++) {
			int maxsize = std::min(300 - y, 300 - x);
			for (int size = 1; size < maxsize; size++) {
				auto tmp = GetArea(x, y, size);
				if (tmp > max_area.first) {
					max_area = std::make_pair(tmp, std::make_pair(point(x, y), size));
				}
				if (size == 3 && tmp > max_area_3x3.first) {
					max_area_3x3 = std::make_pair(tmp, point(x, y));
				}
			}
		}
	}
	std::cout << "Part 1: " << max_area_3x3.second.X << "," << max_area_3x3.second.Y << std::endl;
	std::cout << "Part 2: " << max_area.second.first.X << "," << max_area.second.first.Y << "," << max_area.second.second;
}
