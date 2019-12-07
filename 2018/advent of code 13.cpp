/*very long but satisfying to see*/
#include <fstream>
#include <map>
#include <string>
#include <iostream>
#include <cstdint>
#include <vector>
#include <algorithm>

class Cart {
public:
	enum direction {
		UP,
		DOWN,
		LEFT,
		RIGHT
	};
	static std::map<enum Cart::direction, enum Cart::direction> turn_left;
	static std::map<enum Cart::direction, enum Cart::direction> turn_right;
	static std::map<char, enum Cart::direction> map_cart;
	int x = 0;
	int y = 0;
	Cart(int y, int x, char direction) :x(x), y(y), direction(map_cart[direction]) {};
	bool Move();
	bool collided = false;
	direction direction = UP;
private:
	void Turn();
	int turn_counter = 0;
};

class Track {
public:
	enum type {
		VERTICAL,
		HORIZONTAL,
		CURVE_0,
		CURVE_90,
		CURVE_180,
		CURVE_270,
		INTERSECTION
	};
	static std::map<char, enum Track::type> map_track;
	Track(int y, int x, type _type) :x(x), y(y), type(_type), occupied(true) {};
	Track(int y, int x, char tile, char nexttile) :x(x), y(y) {
		if(tile == '\\' || tile == '/') {
			if(tile == '\\') {
				switch(nexttile) {
					case '+':
					case '-':
					case '>':
					case '<':
					{
						type = CURVE_270;
						break;
					}
					default:
					{
						type = CURVE_90;
						break;
					}
				}
			} else if(tile == '/') {
				switch(nexttile) {
					case '+':
					case '-':
					case '>':
					case '<':
					{
						type = CURVE_0;
						break;
					}
					default:
					{
						type = CURVE_180;
						break;
					}
				}
			}
		} else {
			type = map_track[tile];
		}
	};
	type type = VERTICAL;
private:
	bool occupied = false;
	int x = 0;
	int y = 0;
};

using railway = std::map<std::pair<int, int>, std::pair<Track, Cart*>>;

railway map;


std::map<enum Cart::direction, enum Cart::direction> Cart::turn_left = { { UP, LEFT }, { LEFT,DOWN }, { DOWN,RIGHT }, { RIGHT,UP } };
std::map<enum Cart::direction, enum Cart::direction> Cart::turn_right = { { UP, RIGHT }, { RIGHT,DOWN }, { DOWN,LEFT }, { LEFT,UP } };
std::map<char, enum Cart::direction> Cart::map_cart = { { '>', RIGHT }, { 'v',DOWN }, { '<',LEFT }, { '^',UP } };

bool Cart::Move() {
	static std::map<enum Cart::direction, int> incx{ { UP, 0 }, { LEFT,-1 }, { DOWN,0 }, { RIGHT,1 }};
	static std::map<enum Cart::direction, int> incy{ { UP, -1 }, { LEFT,0 }, { DOWN,1 }, { RIGHT,0 }};
	map.at(std::make_pair(y, x)).second = nullptr;
	x += incx[direction];
	y += incy[direction];
	auto& newtrack = map.at(std::make_pair(y, x));
	if(newtrack.second) {
		collided = true;
		newtrack.second->collided = true;
		newtrack.second = nullptr;
		return false;
	} else {
		newtrack.second = this;
		if(newtrack.first.type == Track::type::INTERSECTION) {
			Turn();
		} else if(newtrack.first.type == Track::type::CURVE_0) {
			if(direction == UP)
				direction = RIGHT;
			else
				direction = DOWN;
		} else if(newtrack.first.type == Track::type::CURVE_90) {
			if(direction == RIGHT)
				direction = DOWN;
			else
				direction = LEFT;
		} else if(newtrack.first.type == Track::type::CURVE_180) {
			if(direction == DOWN)
				direction = LEFT;
			else
				direction = UP;
		} else if(newtrack.first.type == Track::type::CURVE_270) {
			if(direction == LEFT)
				direction = UP;
			else
				direction = RIGHT;
		}
	}
	return true;
}

void Cart::Turn() {
	if(turn_counter == 0) {
		direction = turn_left[direction];
	} else if(turn_counter == 2) {
		direction = turn_right[direction];
	}
	turn_counter = (turn_counter + 1) % 3;
}

std::vector<Cart> carts;
std::map<char, enum Track::type> Track::map_track = { { '|', VERTICAL }, { '-',HORIZONTAL }, { '+',INTERSECTION } };

railway ParseMap(std::ifstream& input) {
	railway ret;
	std::string str;
	int y = 0;
	while(std::getline(input, str)) {
		for(int x = 0; x < str.size(); x++) {
			char cur = str[x];
			if(cur == '<' || cur == '>' || cur == '^' || cur == 'v') {
				carts.emplace_back(y, x, cur);
				Cart* cart = &carts[carts.size() - 1];
				enum Track::type type = Track::VERTICAL;
				if(cur == '<' || cur == '>')
					type = Track::HORIZONTAL;
				auto t=Track(y, x, type);
				ret.insert({ {y, x},std::make_pair(t, cart) });
			} else if(cur != ' ') {
				auto t = Track(y, x, cur, (x < str.size()) ? str[x + 1] : '\0');
				ret.insert({ {y, x},std::make_pair(t, nullptr) });
			}
		}
		y++;
	}
	return ret;
}

struct less_than_key {
	inline bool operator() (Cart* cart1, Cart* cart2) {
		return cart1->y < cart2->y || (cart1->y == cart2->y && cart1->x < cart2->x);
	}
};

int main() {
	std::ifstream input("input13.txt");
	carts.reserve(200);
	map = ParseMap(input);
	int step = 0;
	std::vector<Cart*> cartsptr;
	for(auto& cart : carts) {
		cartsptr.push_back(&cart);
	}
	while(cartsptr.size()>1) {
		step++;
		sort(cartsptr.begin(), cartsptr.end(), less_than_key());
		for(auto& cart : cartsptr) {
			if(cart->collided)
				continue;
			if(!cart->Move()) {
				std::cout << "collision detected at: " << cart->x << "," << cart->y << std::endl;
				//return 0;
			}
		}
		for(auto cit = cartsptr.begin(); cit != cartsptr.end();) {
			if((*cit)->collided)
				cit = cartsptr.erase(cit);
			else
				cit++;
		}
	}
	std::cout << "the last remaining cart is at location " << cartsptr.back()->x << "," << cartsptr.back()->y;
	return 0;
}
