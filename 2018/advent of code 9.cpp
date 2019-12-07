#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <list>
#include <map>
#include <algorithm>
#include <cstring>
#include <iterator>

int main() {
	std::ifstream input("input9.txt");
	std::getline(input, str);
	int players;
	int marbles;
	sscanf(str.c_str(), "%d players; last marble is worth %d points", &players, &marbles);
	marbles++;
	std::list<int> marble = { 0 };
	auto it = marble.begin();
	int cur_location = 0;
	std::vector<unsigned long long> all_players(players);
	int cur_player = 0;
	for (int i = 1; i < marbles; i++, cur_player = (cur_player+1) % players) {
		if (!(i % 23)) {
			all_players[cur_player] += i;
			if (cur_location < 7) {
				cur_location = marble.size() - (7 - cur_location);
			} else {
				cur_location -= 7;
			}
			auto it = marble.begin();
			all_players[cur_player] += *it,std::advance(it, cur_location);
			marble.erase(it);
		} else {
			cur_location = (cur_location + 2) % marble.size();
			auto it = marble.begin();
			std::advance(it, cur_location);
			marble.insert(it,i);
		}
	}
	unsigned long long max_score = 0;
	for (auto& player : all_players) {
		max_score = std::max(player, max_score);
	}
	std::cout << "The max score is; " << max_score << std::endl;
	for (int i = marbles; i < marbles * 100; i++, cur_player = (cur_player + 1) % players) {
		if (!(i % 23)) {
			all_players[cur_player] += i;
			if (cur_location < 7) {
				cur_location = marble.size() - (7 - cur_location);
			} else {
				cur_location -= 7;
			}
			auto it = marble.begin();
			all_players[cur_player] += *it, std::advance(it, cur_location);
			marble.erase(it);
		} else {
			cur_location = (cur_location + 2) % marble.size();
			auto it = marble.begin();
			std::advance(it, cur_location);
			marble.insert(it, i);
		}
	}
	max_score = 0;
	for (auto& player : all_players) {
		max_score = std::max(player, max_score);
	}
	std::cout << "The max score 100 tiems greater is: " << max_score << std::endl;
	return 0;
}
