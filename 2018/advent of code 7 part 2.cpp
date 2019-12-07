#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <set>
#include <cstring>

class step {
public:
	char step_id;
	bool completed;
	std::set<char> required_steps;
	int time_needed;
	step():step_id(0), time_needed(0), completed(false){};
	step(const std::string& input):step_id(0), time_needed(0), completed(false) {
		Format(input);
	};
	void Format(const std::string& input) {
		char required_step;
		sscanf(input.c_str(), "Step %c must be finished before step %c can begin.", &required_step, &step_id);
		required_steps.insert(required_step);
		time_needed = step_id - 4;
	}
	bool IsCompleted() {
		return completed;
	}
};

class step_thread {
public:
	char id;
	int time_needed;
public:
	step_thread() :id(0), time_needed(0) {};
	step_thread(step cur_step) {
		Set(cur_step);
	};
	void Set(step cur_step) {
		id = cur_step.step_id;
		time_needed = cur_step.time_needed;
	}
	char GetId() {
		return id;
	}
	bool Update() {
		return --time_needed == 0;
	}
	bool IsValid() {
		return id && time_needed > 0;
	}
};

int main() {
	std::ifstream input("input7.txt");
	std::string str;
	std::map<int,step> steps;
	while (std::getline(input, str)) {
		if (str.empty())
			continue;
		step tmp_step(str);
		if (steps[tmp_step.step_id].step_id) {
			steps[tmp_step.step_id].required_steps.insert(tmp_step.required_steps.begin(), tmp_step.required_steps.end());
			for (auto id : steps[tmp_step.step_id].required_steps) {
				if (!steps[id].time_needed) {
					steps[id].time_needed = id - 4;
					steps[id].step_id = id;
				}
			}
		} else {
			steps[tmp_step.step_id] = tmp_step;
			for (auto id : steps[tmp_step.step_id].required_steps) {
				if (!steps[id].time_needed) {
					steps[id].time_needed = id - 4;
					steps[id].step_id = id;
				}
			}
		}
	}
	input.close();
	std::string res = "";
	std::vector<step_thread> threads;
	for (int i = 0; i < 5; i++)
		threads.push_back(step_thread());
	int cycles = 0;
	while (true) {
		for (auto& thread : threads) {
			if (thread.IsValid()) {
				if (thread.Update()) {
					steps[thread.GetId()].completed = true;
				}
			}
		}
		for (auto& step : steps) {
			if (step.second.IsCompleted()) {
				if (res.find(step.first) == std::string::npos) {
					res += step.first;
					break;
				}
			}
		}
		bool all_complete = true;
		for (auto& step : steps) {
			if (!step.second.IsCompleted()) {
				all_complete = false;
				break;
			}
		}
		if (all_complete)
			break;
		cycles++;
		for (auto& step : steps) {
			if (step.second.IsCompleted())
				continue;
			bool completed = true;
			for (auto id : step.second.required_steps) {
				if (!steps[id].IsCompleted() || (steps[id].IsCompleted() && res.find(id) == std::string::npos)) {
					completed = false;
					break;
				}
			}
			for (auto& thread : threads) {
				if (thread.GetId() == step.first) {
					completed = false;
					break;
				}
			}
			if (completed) {
				for (auto& thread : threads) {
					if (!thread.IsValid()) {
						thread.Set(step.second);
						break;
					}
				}
			}
		}
	}
	std::cout << "the number of seconds passed is: " << cycles << std::endl;
    return 0;
}