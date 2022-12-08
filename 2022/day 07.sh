#!/bin/sh

cur_path=""

go_up_one_path() {
	cur_path=$(dirname $cur_path)/
	if [ $cur_path = "//" ]; then
		cur_path="/"
	fi
}

change_path_to() {
	if [ $1 = "/" ]; then
		cur_path="/"
	elif [ $1 = ".." ]; then
		go_up_one_path
	else
		cur_path="${cur_path}${1}/"
	fi
	# echo "Changed path, now pointing to $cur_path"
}

parse_command() {
	if [ $1 = "$" ]; then
		if [ $2 = "cd" ]; then
			# echo "Changing directory to: ${3}"
			change_path_to $3
		# else
			# echo "Listing contents in current directory"
		fi
	elif [ $1 != "dir" ]; then
		# echo "We got a directory entry with name ${2}"
	# else
		# echo "We got a file entry"
		echo "$cur_path${2} ${1}" >> /tmp/aoc_2022_day_7_part_1_files
	fi
}

rm -f /tmp/aoc_2022_day_7_part_1_files /tmp/aoc_2022_day_7_part_1_files_totals

while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
	parse_command $line
done < input7.txt

sort -u -r -o /tmp/aoc_2022_day_7_part_1_files /tmp/aoc_2022_day_7_part_1_files

cur_path=""
total=0

parse_file() {
	full_path=$1
	size=$2
	base_path=$(dirname $1)/
	# echo $base_path
	if [ $base_path = "//" ]; then
		base_path="/"
	fi
	if [ "$cur_path" != "$base_path" ]; then
		if [ -n "$cur_path" ]; then
			printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_part_1_files
		fi
		total=0
		cur_path=$base_path
	fi
	total=$((total + size))
}

for i in $(seq 1 1); do
	cat /tmp/aoc_2022_day_7_part_1_files > /tmp/cur_input
	echo "" > /tmp/aoc_2022_day_7_part_1_files
	while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
		if [ -z "$line" ]; then
			break
		fi
		parse_file $line
	done < /tmp/cur_input
	if [ -n "$cur_path" ]; then
		printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_part_1_files
	fi
	sort -u -r -o /tmp/aoc_2022_day_7_part_1_files /tmp/aoc_2022_day_7_part_1_files
	cat /tmp/aoc_2022_day_7_part_1_files >> /tmp/aoc_2022_day_7_part_1_files_totals
done
cur_path=""
total=0

parse_file2() {
	full_path=$1
	size=$2
	base_path=$(dirname $1)/
	if [ "$full_path" = "$cur_path" ]; then
		# echo "We got a match"
		base_path=$full_path
	elif [ $base_path = "//" ]; then
		base_path="/"
		# echo "$full_path $size"
		# echo "$full_path $size" >> /tmp/aoc_2022_day_7_part_1_files_totals
		# return 0
	fi
	# echo "Parsing file full_path: $full_path, size: $size, base_path: $base_path, current total size: $(printf "%012d\n" $total)"
	if [ "$cur_path" != "$base_path" ]; then
		if [ -n "$cur_path" ]; then
			printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_part_1_files
			total=0
		fi
		cur_path=$base_path
	fi
	# if [ $full_path != $cur_path ]; then
		total=$((total + size))
	# fi
}

for i in $(seq 1 15); do
	cat /tmp/aoc_2022_day_7_part_1_files > /tmp/cur_input
	echo "" > /tmp/aoc_2022_day_7_part_1_files
	while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
		if [ -z "$line" ]; then
			break
		fi
		parse_file2 $line
	done <<EOF
$(sed -e 's/ 0*/ /' -e '/^$/d' /tmp/cur_input)
EOF
	if [ -n "$cur_path" ]; then
		printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_part_1_files
	fi
	sort -u -r -o /tmp/aoc_2022_day_7_part_1_files /tmp/aoc_2022_day_7_part_1_files
	cat /tmp/aoc_2022_day_7_part_1_files >> /tmp/aoc_2022_day_7_part_1_files_totals
done
# sort -u -r -o /tmp/aoc_2022_day_7_part_1_files_totals
sort -u -r -o /tmp/aoc_2022_day_7_part_1_files_totals /tmp/aoc_2022_day_7_part_1_files_totals
awk '!_[$1]++' /tmp/aoc_2022_day_7_part_1_files_totals > /tmp/aoc_2022_day_7_part_1_files_totals_uniq

total=0
sum_folder() {
	folder_path=$1
	folder_size=$2
	total=$((total + folder_size))
}
while read -r line; do
	sum_folder $line
done <<EOF
$(sed -e 's/ 0*/ /' /tmp/aoc_2022_day_7_part_1_files_totals_uniq | awk '$2 <= 100000')
EOF

echo "Part 1: $total"







