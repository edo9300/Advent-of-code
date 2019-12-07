#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>
#include <cstring>
#define NOMINMAX
#include<windows.h>
#include <cmath>

class simple_vector {
public:
	int X;
	int Y;
	simple_vector() :X(0), Y(0) {};
	simple_vector(int x, int y) :X(x), Y(y) {};
};
class point {
	simple_vector position;
	simple_vector velocity;
public:
	point(){};
	point(const std::string& input) {
		int tmpx1, tmpy1, tmpx2, tmpy2;
		sscanf(input.c_str(), "position = < %d, %d> velocity = <%d, %d>", &tmpx1, &tmpy1, &tmpx2, &tmpy2);
		position.X = tmpx1;
		position.Y = tmpy1;
		velocity.X = tmpx2;
		velocity.Y = tmpy2;
	};
	void UpdatePosition(bool negative = false) {
		if (negative) {
			position.X -= velocity.X;
			position.Y -= velocity.Y;
		} else {
			position.X += velocity.X;
			position.Y += velocity.Y;
		}
	};
	int GetX() {
		return position.X;
	}
	int GetY() {
		return position.Y;
	}
};

void DrawPoints(std::vector<point>& points, int minx, int miny) {
	//Get a console handle
	HWND myconsole = GetConsoleWindow();
	//Get a handle to device context
	HDC mydc = GetDC(myconsole);
	int pixel = 0;

	//Choose any color
	COLORREF COLOR = 0xffffff;

	//Draw pixels
	for (auto& point : points) {
		SetPixel(mydc, point.GetX() - minx, point.GetY() - miny, COLOR);
	}

	ReleaseDC(myconsole, mydc);
}


int main() {
	std::ifstream input("input10.txt");
	std::string str;
	std::vector<point> points;
	while (std::getline(input, str)) {
		if (str.size()) {
			points.push_back(point(str));
		}
	}
	int i = 0;
	int smallest_distance = 100000000;
	bool reverting = false;
	for (;; i++) {
		for (auto& point : points) {
			point.UpdatePosition(reverting);
		}
		int maxy = -100000000000;
		int miny = 100000000000;
		int maxx = -100000000000;
		int minx = 100000000000;
		for (auto& point : points) {
			maxy = std::max(point.GetY(), maxy);
			miny = std::min(point.GetY(), miny);
			maxx = std::max(point.GetX(), maxx);
			minx = std::min(point.GetX(), minx);
		}
		int distance = abs(miny - maxy);
		smallest_distance = std::min(distance, smallest_distance);
		if (reverting) {
			std::cout << std::endl;
			DrawPoints(points, minx, miny);
			std::cout << "The amount of seconds passed is: " << i << std::endl;
			break;
		}
		if (distance != smallest_distance) {
			reverting = true;
			i--;
		}
			
	}
	return 0;
}
