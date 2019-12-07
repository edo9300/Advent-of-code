#include <fstream>
#include <map>
#include <string>
#include <iostream>
#include <cstdint>
#include <vector>
#include <algorithm>

class Orbit {
public:
	std::string name;
	Orbit* parent;
	std::vector<Orbit*> children;
	int CountOrbits();
	int GetParentsCount();
	bool FindOrbit(Orbit* target, bool lookup_parent, Orbit* caller, int& count);
	Orbit(const std::string& name):name(name), parent(nullptr){};
	Orbit() {};
};

int Orbit::CountOrbits() {
	int tot = 0;
	for(auto& child : children) {
		tot += child->CountOrbits() + child->GetParentsCount();
	}
	return tot;
}

bool Orbit::FindOrbit(Orbit* target, bool lookup_parent, Orbit* caller, int& count) {
	if(this == target) {
		return true;
	}
	for(auto& child : children) {
		if(child != caller) {
			if(child->FindOrbit(target, false, nullptr, count)) {
				count += 1;
				return true;
			}
		}
	}
	if(lookup_parent && parent) {
		if(parent->FindOrbit(target, true, this, count)) {
			count += 1;
			return true;
		}
	}
	return false;
}

int Orbit::GetParentsCount() {
	int tot = 0;
	if(parent)
		tot = 1 + parent->GetParentsCount();
	return tot;
}

int main() {
	std::ifstream input("input6.txt");
	std::string str;
	std::map<std::string, Orbit> orbits;
	while(std::getline(input, str)) {
		if(str.size() < 3)
			continue;
		auto pos = str.find(")");
		if(pos == std::string::npos)
			continue;
		auto name = str.substr(0, pos);
		auto childname = str.substr(pos + 1, str.size());
		if(!orbits.count(childname)) {
			orbits[childname] = Orbit(childname);
		}
		if(!orbits.count(name)) {
			orbits[name] = Orbit(name);
		}
		auto parent = &orbits[name];
		auto child = &orbits[childname];
		child->parent = parent;
		parent->children.push_back(child);
	}
	std::cout << orbits["COM"].CountOrbits() <<std::endl;
	int res = -2;
	orbits["YOU"].FindOrbit(&orbits["SAN"], true, nullptr, res);
	std::cout << res <<std::endl;
	return 0;
}
