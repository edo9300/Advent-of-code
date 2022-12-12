#!/bin/sh
set -f

divisors=1
total_monkeys=0

generate_monkey() {
	eval "monkey_${current_monkey}_operator=$current_operator"
	eval "monkey_${current_monkey}_operand=$current_operand"
	eval "monkey_${current_monkey}_divisible_by=$divisible_by"
	eval "monkey_${current_monkey}_true_branch=$true_monkey"
	eval "monkey_${current_monkey}_false_branch=$false_monkey"
	eval "monkey_${current_monkey}_items='$monkey_items'"
	total_monkeys=$((total_monkeys + 1))
}

do_thing() {
	if [ "$1" = "Monkey" ]; then
		current_monkey="$2"
		needs_starting=0
	elif [ "$needs_starting" -eq 0 ]; then
		monkey_items="$*"
		needs_starting=1
	elif [ "$1" = '+' ] || [ "$1" = '*' ]; then
		current_operator="$1"
		current_operand="$2"
	elif [ "$1" = "Test" ]; then
		divisible_by="$4"
		divisors=$((divisors*divisible_by))
	elif [ "$1" = "If" ]; then
		if [ "$2" = "true" ]; then
			true_monkey="$6"
		else
			false_monkey="$6"
			generate_monkey
		fi
	fi
}

while read -r line; do #Thing needed so that no newline is needed at the end of the input
	do_thing $line
done <<EOF
$(sed -e 's/.*new = old \(.*\)/\1/' -e 's/.*items//' -e 's/[:,]//g' input11.txt) 
EOF

get_operator() {
	eval "operator"='$'"monkey_${1}_operator"
	eval "operand"='$'"monkey_${1}_operand"	
}

get_monkey_divisible_by() {
	eval "divisible_by"='$'"monkey_${1}_divisible_by"
}

get_monkey_true_branch() {
	eval "true_branch"='$'"monkey_${1}_true_branch"
}

get_monkey_false_branch() {
	eval "false_branch"='$'"monkey_${1}_false_branch"
}

get_and_clear_monkey_items() {
	eval "items"='$'"monkey_${1}_items"
	eval "monkey_${1}_items"=""
}

get_monkey_items() {
	eval "items"='$'"monkey_${1}_items"
}

push_item_to_monkey() {
	monkey="$1"
	tmp_item="$2"
	get_monkey_items $monkey
	items="$items $tmp_item"
	eval "monkey_${monkey}_items"='$'"items"
}

print_monkey_items() {
	current_monkey=0
	echo ---
	while [ "$current_monkey" -lt "$total_monkeys" ]; do
		printf "Monkey %d:" $current_monkey
		get_monkey_items $current_monkey
		echo "$items"
		current_monkey=$((current_monkey + 1))
	done
}

get_inspected_items() {
	monkey=$1
	string="inspected_items"='$'"inspected_items_monkey_${monkey}"
	eval $string
}

set_inspected_items() {
	monkey=$1
	money=$2
	string="inspected_items_monkey_${monkey}"="$money"
	eval $string
}

print_monkey_inspection_stats() {
	current_monkey=0
	while [ "$current_monkey" -lt "$total_monkeys" ]; do
		get_inspected_items $current_monkey
		echo "$inspected_items"
		current_monkey=$((current_monkey + 1))
	done
}

normalize() {
	if [ "$part" -eq 1 ]; then
		new=$((new / 3))
	elif [ "$new" -ge "$divisors" ]; then
		new=$((new % divisors))
	fi
}

run_game() {
	part=$1
	round_counter=0
	if [ "$part" -eq 1 ]; then
		max=20
	else
		max=10000
	fi
	while [ "$round_counter" -lt $max ]; do
		current_monkey=0
		while [ "$current_monkey" -lt "$total_monkeys" ]; do
			get_operator $current_monkey
			get_monkey_divisible_by $current_monkey
			get_monkey_true_branch $current_monkey
			get_monkey_false_branch $current_monkey
			get_monkey_items $current_monkey
			get_and_clear_monkey_items $current_monkey
			iterable_items=$items
			get_inspected_items $current_monkey
			for item in $iterable_items; do
				used_operand=$operand
				if [ "$operator" = '+' ]; then
					new=$((item + operand))
				else
					if [ "$operand" = "old" ]; then
						used_operand=$item
					fi
					new=$((item * used_operand))
				fi
				normalize
				if [ $((new % divisible_by)) -eq 0 ]; then
					push_item_to_monkey $true_branch $new
				else
					push_item_to_monkey $false_branch $new
				fi
				inspected_items=$((inspected_items + 1))
			done
			set_inspected_items $current_monkey $inspected_items
			current_monkey=$((current_monkey + 1))
		done
		round_counter=$((round_counter + 1))
	done
	result=1
	for number in $(print_monkey_inspection_stats | sort -n | tail -n2); do
		result=$((result * number))
	done
	echo $result
}
echo "Part 1: $(run_game 1)"
echo "Part 2: $(run_game 2)"
