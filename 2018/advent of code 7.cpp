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
	std::set<char> required_steps;
	bool completed;
	step():step_id(0), completed(false){};
	step(const std::string& input):step_id(0), completed(false) {
		Format(input);
	};
	void Format(const std::string& input) {
		char required_step;
		sscanf(input.c_str(), "Step %c must be finished before step %c can begin.", &required_step, &step_id);
		required_steps.insert(required_step);
	}
	bool IsCompleted() {
		return completed || required_steps.empty();
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
			for (auto a : steps[tmp_step.step_id].required_steps) {
				steps[a];
			}
		} else {
			steps[tmp_step.step_id] = tmp_step;
			for (auto a : steps[tmp_step.step_id].required_steps) {
				steps[a];
			}
		}
	}
	input.close();
	std::string res = "";
	while (true) {
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
		for (auto& step : steps) {
			bool completed = true;
			for (auto id : step.second.required_steps) {
				if (!steps[id].IsCompleted() || (steps[id].IsCompleted() && res.find(id) == std::string::npos)) {
					completed = false;
				}
			}
			if (completed) {
				steps[step.first].completed = true;
			}
		}
	}
	std::cout << "the correct order is: " << res << std::endl;
    return 0;
}