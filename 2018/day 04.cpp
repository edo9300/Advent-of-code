#include <iostream>
#include <cstdio>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <algorithm>

class time {
public:
	int year;
	int month;
	int day;
	int hour;
	int mins;
	time():year(0), month(0), day(0), hour(0), mins(0) {};
	void Format(const std::string& input) {
		sscanf(input.c_str(), "[%d-%d-%d %d:%d]", &year, &month, &day, &hour, &mins);
	};
};

inline bool operator< (time lhs, time rhs) {
#define LF(x, y) if (lhs.##x == rhs.##x) {y} else {return lhs.##x < rhs.##x;}
	LF(year, LF(month, LF(day, LF(hour, LF(mins, return false;)))))
#undef LF
	return false;
}

inline int operator- (time lhs, time rhs) {
	return (lhs.hour - rhs.hour) * 60 + (lhs.mins - rhs.mins);
}

class action {
public:
	enum action_type {
		turn_start,
		falls_asleep,
		wakes_up,
		none
	};
	action_type type;
	int guard_id;
	action() :guard_id(0), type(none){};
	void Format(const std::string& input) {
		if (input[0] == 'G') {
			type = turn_start;
			sscanf(input.c_str(), "Guard #%d begins shift", &guard_id);
		}
		if (input[0] == 'w') {
			type = wakes_up;
		}
		if (input[0] == 'f') {
			type = falls_asleep;
		}
	};
};

class logline {
public:
	time time;
	action action;
	logline() {};
};

int main() {
	std::ifstream input("input4.txt");
	std::string str;
	std::vector<logline> inputs;
	while (std::getline(input, str)) {
		if (str.empty())
			continue;
		logline tmpline;
		tmpline.time.Format(str.substr(0, 18));
		tmpline.action.Format(str.substr(19));
		inputs.push_back(tmpline);
	}
	input.close();
	std::sort(inputs.begin(), inputs.end(), [](logline l1, logline l2) {return l1.time < l2.time;});
	std::map<int/*guard id*/, std::map<int/*specific asleep minute*/, int/*times asleep that minute*/>> guards;
	int cur_guard = 0;
	time* prev_timestamp = nullptr;
	bool awake = true;
	for (auto& line : inputs) {
		auto& action = line.action;
		if (!cur_guard && action.type != action::action_type::turn_start)
			continue;
		if ((action.type == action::action_type::turn_start || action.type == action::action_type::wakes_up)) {
			if(action.type != action::action_type::wakes_up)
				cur_guard = action.guard_id;
			if (prev_timestamp) {
				int mins = line.time - *prev_timestamp;
				for (int i = prev_timestamp->mins, j = 0; j < mins; i = (i + 1) % 60, j++) {
					guards[cur_guard][i]++;
				}
				prev_timestamp = nullptr;
			}
		}
		if (action.type == action::action_type::falls_asleep)
			prev_timestamp = &line.time;
	}
	/*PART 1*/
	std::pair<int/*guard id*/, int/*total minutes*/> target_guard = { 0,0 };
	for (auto& a : guards) {
		int max = 0;
		for (auto& b : a.second)
			max+= b.second;
		if (max > target_guard.second)
			target_guard = { a.first, max };
	}
	int max_min = 0;
	for (int i = 1; i < 60; i++) {
		if (guards[target_guard.first][i] > guards[target_guard.first][max_min])
			max_min = i;
	}
	std::cout << "the first answer is: " << target_guard.first * max_min << std::endl;

	/*PART 2*/
	std::pair<int/*guard id*/, int/*most slept minute*/> target_guard_2 = { 0,0 };
	for (auto& a : guards) {
		max_min = 0;
		for (int i = 1; i < 60; i++) {
			if (a.second[i] > a.second[max_min])
				max_min = i;
		}
		if (guards[target_guard_2.first][target_guard_2.second] < a.second[max_min])
			target_guard_2 = { a.first , max_min };
	}
	std::cout << "the second answer is: " << target_guard_2.first * target_guard_2.second << std::endl;
    return 0;
}

