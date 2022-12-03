#!/bin/sh

get_priority() {
	letter=$1
	if [ "$letter" = "a" ]; then
		return 1
	elif [ "$letter" = "b" ]; then
		return 2
	elif [ "$letter" = "c" ]; then
		return 3
	elif [ "$letter" = "d" ]; then
		return 4
	elif [ "$letter" = "e" ]; then
		return 5
	elif [ "$letter" = "f" ]; then
		return 6
	elif [ "$letter" = "g" ]; then
		return 7
	elif [ "$letter" = "h" ]; then
		return 8
	elif [ "$letter" = "i" ]; then
		return 9
	elif [ "$letter" = "j" ]; then
		return 10
	elif [ "$letter" = "k" ]; then
		return 11
	elif [ "$letter" = "l" ]; then
		return 12
	elif [ "$letter" = "m" ]; then
		return 13
	elif [ "$letter" = "n" ]; then
		return 14
	elif [ "$letter" = "o" ]; then
		return 15
	elif [ "$letter" = "p" ]; then
		return 16
	elif [ "$letter" = "q" ]; then
		return 17
	elif [ "$letter" = "r" ]; then
		return 18
	elif [ "$letter" = "s" ]; then
		return 19
	elif [ "$letter" = "t" ]; then
		return 20
	elif [ "$letter" = "u" ]; then
		return 21
	elif [ "$letter" = "v" ]; then
		return 22
	elif [ "$letter" = "w" ]; then
		return 23
	elif [ "$letter" = "x" ]; then
		return 24
	elif [ "$letter" = "y" ]; then
		return 25
	elif [ "$letter" = "z" ]; then
		return 26
	elif [ "$letter" = "A" ]; then
		return 27
	elif [ "$letter" = "B" ]; then
		return 28
	elif [ "$letter" = "C" ]; then
		return 29
	elif [ "$letter" = "D" ]; then
		return 30
	elif [ "$letter" = "E" ]; then
		return 31
	elif [ "$letter" = "F" ]; then
		return 32
	elif [ "$letter" = "G" ]; then
		return 33
	elif [ "$letter" = "H" ]; then
		return 34
	elif [ "$letter" = "I" ]; then
		return 35
	elif [ "$letter" = "J" ]; then
		return 36
	elif [ "$letter" = "K" ]; then
		return 37
	elif [ "$letter" = "L" ]; then
		return 38
	elif [ "$letter" = "M" ]; then
		return 39
	elif [ "$letter" = "N" ]; then
		return 40
	elif [ "$letter" = "O" ]; then
		return 41
	elif [ "$letter" = "P" ]; then
		return 42
	elif [ "$letter" = "Q" ]; then
		return 43
	elif [ "$letter" = "R" ]; then
		return 44
	elif [ "$letter" = "S" ]; then
		return 45
	elif [ "$letter" = "T" ]; then
		return 46
	elif [ "$letter" = "U" ]; then
		return 47
	elif [ "$letter" = "V" ]; then
		return 48
	elif [ "$letter" = "W" ]; then
		return 49
	elif [ "$letter" = "X" ]; then
		return 50
	elif [ "$letter" = "Y" ]; then
		return 51
	elif [ "$letter" = "Z" ]; then
		return 52
	fi
}

get_sum_of_priorities() {
	total=0
	for line in "$@"; do
		get_priority "$line"
		total=$((total + $?))
	done
}

write_unique_sorted_to_file() {
	echo "$@" | tr " " "\n" | sort | uniq > "$file"
}

split_rucksacks() {
	sack_size=$(($# / 2))
	first_half=""
	second_half=""
	counter=0
	for var in "$@"; do
		if [ $counter -lt $sack_size ]; then
			first_half="${first_half} ${var}"
		else
			second_half="${second_half} ${var}"
		fi
		counter=$((counter + 1))
	done
	file=/tmp/aoc_2022_day3_part1_tmp1
	write_unique_sorted_to_file "$first_half"
	file=/tmp/aoc_2022_day3_part1_tmp2
	write_unique_sorted_to_file "$second_half"
	comm -12 /tmp/aoc_2022_day3_part1_tmp1 /tmp/aoc_2022_day3_part1_tmp2
}

counter=0
check_badges_part_2() {
	total=0
	file="/tmp/aoc_2022_day3_part2_tmp${counter}"
	write_unique_sorted_to_file "$@"
	if [ "$counter" -eq 2 ]; then
		get_sum_of_priorities $(comm -12 /tmp/aoc_2022_day3_part2_tmp0 /tmp/aoc_2022_day3_part2_tmp1 | comm -12 /tmp/aoc_2022_day3_part2_tmp2 -)
	fi
	counter=$(($((counter + 1)) % 3))
}


while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
	word_as_individual_chars=$(echo "$line" | fold -w1)
	get_sum_of_priorities $(split_rucksacks $word_as_individual_chars)
	part_1=$((part_1 + total))
	check_badges_part_2 $word_as_individual_chars
	part_2=$((part_2 + total))
done < input3.txt
echo Part 1: "$part_1"
echo Part 2: "$part_2"
rm -f /tmp/aoc_2022_day3_part1_tmp1 /tmp/aoc_2022_day3_part1_tmp2 /tmp/aoc_2022_day3_part2_tmp0 /tmp/aoc_2022_day3_part2_tmp1 /tmp/aoc_2022_day3_part2_tmp2