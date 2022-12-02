#!/bin/sh

set_throw_score() {
	if [ "$1" = "Rock" ]; then
		throw_score=1
	elif [ "$1" = "Paper" ]; then
		throw_score=2
	elif [ "$1" = "Scissors" ]; then
		throw_score=3
	fi
}

map_thrown_obj() {
	if [ "$1" = "X" ]; then
		self_selection="Rock"
	elif [ "$1" = "Y" ]; then
		self_selection="Paper"
	elif [ "$1" = "Z" ]; then
		self_selection="Scissors"
	elif [ "$1" = "A" ]; then
		oppo_selection="Rock"
	elif [ "$1" = "B" ]; then
		oppo_selection="Paper"
	elif [ "$1" = "C" ]; then
		oppo_selection="Scissors"
	fi
}

get_weak_against() {
	if [ "$1" = "Rock" ]; then
		weak="Scissors"
	elif [ "$1" = "Paper" ]; then
		weak="Rock"
	elif [ "$1" = "Scissors" ]; then
		weak="Paper"
	fi
}

get_strong_against() {
	if [ "$1" = "Rock" ]; then
		strong="Paper"
	elif [ "$1" = "Paper" ]; then
		strong="Scissors"
	elif [ "$1" = "Scissors" ]; then
		strong="Rock"
	fi
}

rig_outcome() {
	oppo=$1
	if [ "$2" = "Y" ]; then #end in a draw
		self_selection=$oppo
	elif [ "$2" = "X" ]; then #lose
		get_weak_against $oppo
		self_selection=$weak
	elif [ "$2" = "Z" ]; then #win
		get_strong_against $oppo
		self_selection=$strong
	fi
}

set_victory_points() {
	oppo=$1
	self=$2
	if [ "$self" = "$oppo" ]; then #draw
		victory_points=3
	else
		get_weak_against $oppo
		if [ "$self" = $weak ]; then
			victory_points=0
		else
			victory_points=6
		fi
	fi
}

get_score_part_1() {
	map_thrown_obj $1
	map_thrown_obj $2
	set_throw_score $self_selection
	set_victory_points $oppo_selection $self_selection
	total_1=$((total_1 + victory_points + throw_score))
}

get_score_part_2() {
	map_thrown_obj $1
	rig_outcome $oppo_selection $2
	set_throw_score $self_selection
	set_victory_points $oppo_selection $self_selection
	total_2=$((total_2 + victory_points + throw_score))
}

while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
	get_score_part_1 $line
	get_score_part_2 $line
done < input2.txt

echo $total_1
echo $total_2
