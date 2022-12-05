#!/bin/sh

get_sum_of_priorities() {
	total=0
	for line in "$@"; do
		total=$((total + line))
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
	comm -12 /tmp/aoc_2022_day3_part1_tmp1 /tmp/aoc_2022_day3_part1_tmp2 >> /tmp/aoc_2022_day3_part1_totals
}

part2_counter=0
check_badges_part_2() {
	total=0
	file="/tmp/aoc_2022_day3_part2_tmp${part2_counter}"
	write_unique_sorted_to_file "$@"
	if [ "$part2_counter" -eq 2 ]; then
		comm -12 /tmp/aoc_2022_day3_part2_tmp0 /tmp/aoc_2022_day3_part2_tmp1 | comm -12 /tmp/aoc_2022_day3_part2_tmp2 - >> /tmp/aoc_2022_day3_part2_totals
	fi
	part2_counter=$(($((part2_counter + 1)) % 3))
}

housekeep() {
	rm -f /tmp/aoc_2022_day3_part1_tmp1 /tmp/aoc_2022_day3_part1_tmp2 /tmp/aoc_2022_day3_part1_totals /tmp/aoc_2022_day3_part2_tmp0 \
		/tmp/aoc_2022_day3_part2_tmp1 /tmp/aoc_2022_day3_part2_tmp2 /tmp/aoc_2022_day3_part2_totals
}

housekeep

while read -r word_as_individual_chars; do
	split_rucksacks $word_as_individual_chars
	check_badges_part_2 $word_as_individual_chars
done <<EOF
$(sed -e 's/a/1 /g' -e 's/b/2 /g' -e 's/c/3 /g' -e 's/d/4 /g' -e 's/e/5 /g' -e 's/f/6 /g' \
-e 's/g/7 /g' -e 's/h/8 /g' -e 's/i/9 /g' -e 's/j/10 /g' -e 's/k/11 /g' -e 's/l/12 /g' \
-e 's/m/13 /g' -e 's/n/14 /g' -e 's/o/15 /g' -e 's/p/16 /g' -e 's/q/17 /g' -e 's/r/18 /g' \
-e 's/s/19 /g' -e 's/t/20 /g' -e 's/u/21 /g' -e 's/v/22 /g' -e 's/w/23 /g' -e 's/x/24 /g' \
-e 's/y/25 /g' -e 's/z/26 /g' -e 's/A/27 /g' -e 's/B/28 /g' -e 's/C/29 /g' -e 's/D/30 /g' \
-e 's/E/31 /g' -e 's/F/32 /g' -e 's/G/33 /g' -e 's/H/34 /g' -e 's/I/35 /g' -e 's/J/36 /g' \
-e 's/K/37 /g' -e 's/L/38 /g' -e 's/M/39 /g' -e 's/N/40 /g' -e 's/O/41 /g' -e 's/P/42 /g' \
-e 's/Q/43 /g' -e 's/R/44 /g' -e 's/S/45 /g' -e 's/T/46 /g' -e 's/U/47 /g' -e 's/V/48 /g' \
-e 's/W/49 /g' -e 's/X/50 /g' -e 's/Y/51 /g' -e 's/Z/52 /g' input3.txt)
EOF

get_sum_of_priorities $(cat /tmp/aoc_2022_day3_part1_totals)
echo Part 1: "$total"
get_sum_of_priorities $(cat /tmp/aoc_2022_day3_part2_totals)
echo Part 2: "$total"

housekeep