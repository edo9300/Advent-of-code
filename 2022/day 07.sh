#!/bin/sh

#We do this so that "sort" will sort strings based on their ascii values
export LC_ALL=C

cur_path=""

housekeep() {
	rm -f /tmp/aoc_2022_day_7_files /tmp/aoc_2022_day_7_files_totals /tmp/aoc_2022_day_7_files_totals_uniq /tmp/aoc_2022_day_7_cur_input
}

housekeep

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
}

parse_command() {
	if [ $1 = "$" ]; then
		if [ $2 = "cd" ]; then
			change_path_to $3
		fi
	elif [ $1 = "dir" ]; then
		echo "$cur_path${2}/ _ 0" >> /tmp/aoc_2022_day_7_files
	else
		echo "$cur_path ${2} ${1}" >> /tmp/aoc_2022_day_7_files
	fi
}

while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
	parse_command $line
done < input7.txt

sort -u -r -o /tmp/aoc_2022_day_7_files /tmp/aoc_2022_day_7_files

get_base_path() {
	base_path=$(dirname $1)/
	if [ $base_path = "//" ]; then
		base_path="/"
	fi
}

cur_path=""
total=0

parse_file() {
	full_path=$1
	size=$3
	base_path=$1
	if [ "$cur_path" != "$base_path" ]; then
		if [ -n "$cur_path" ]; then
			printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_files
		fi
		total=0
		cur_path=$base_path
	fi
	total=$((total + size))
}

cat /tmp/aoc_2022_day_7_files > /tmp/aoc_2022_day_7_cur_input
echo "" > /tmp/aoc_2022_day_7_files
while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
	if [ -z "$line" ]; then
		break
	fi
	parse_file $line
done < /tmp/aoc_2022_day_7_cur_input
if [ -n "$cur_path" ]; then
	printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_files
fi
sort -u -r -o /tmp/aoc_2022_day_7_files /tmp/aoc_2022_day_7_files
cat /tmp/aoc_2022_day_7_files >> /tmp/aoc_2022_day_7_files_totals

total=0

parse_folder() {
	full_path=$1
	size=$2
	get_base_path $1
	printf "%s %012d\n" $base_path $size >> /tmp/aoc_2022_day_7_files
	if [ "$cur_path" != "$full_path" ]; then
		if [ -n "$cur_path" ]; then
			printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_files
			total=0
		fi
		cur_path=$full_path
	fi
	total=$((total + size))
}
longest_path=$(sed 's/[^/]*//g' /tmp/aoc_2022_day_7_files | awk '{print length}'|sort -nr|head -1)

while [ "$longest_path" -ne 0 ]; do
	cur_path=""
	total=0
	cat /tmp/aoc_2022_day_7_files > /tmp/aoc_2022_day_7_cur_input
	echo "" > /tmp/aoc_2022_day_7_files
	while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
		if [ -z "$line" ]; then
			break
		fi
		parse_folder $line
	done <<EOF
$(sed -e 's/ 0*/ /' -e '/^$/d' /tmp/aoc_2022_day_7_cur_input | awk -FN -vcount=$longest_path 'BEGIN { FS = "/" } ;NF==count+1')
EOF
	if [ -n "$cur_path" ]; then
		printf "%s %012d\n" $cur_path $total >> /tmp/aoc_2022_day_7_files
	fi
	awk -FN -vcount=$longest_path 'BEGIN { FS = "/" } ;NF<=count' /tmp/aoc_2022_day_7_cur_input >> /tmp/aoc_2022_day_7_files
	sort -r -o /tmp/aoc_2022_day_7_files /tmp/aoc_2022_day_7_files
	cat /tmp/aoc_2022_day_7_files >> /tmp/aoc_2022_day_7_files_totals
	longest_path=$((longest_path - 1))
done

sort -u -r -o /tmp/aoc_2022_day_7_files_totals /tmp/aoc_2022_day_7_files_totals
#This awk command takes the first occurrence of each path so that the most recent one only is taken and all the others are discarded
awk '!_[$1]++' /tmp/aoc_2022_day_7_files_totals | sed '/^$/d' > /tmp/aoc_2022_day_7_files_totals_uniq

total=0
sum_folder() {
	# folder_path=$1
	folder_size=$2
	total=$((total + folder_size))
}

while read -r line; do
	sum_folder $line
done <<EOF
$(sed -e 's/ 0*/ /' /tmp/aoc_2022_day_7_files_totals_uniq | awk '$2 <= 100000')
EOF

echo "Part 1: $total"

used_space=$(awk '{ print $2 }' /tmp/aoc_2022_day_7_files_totals_uniq | sort | tail -n1 | sed 's/^0*//')
unused_space=$((70000000 - used_space))
space_to_free=$((30000000 - unused_space))
echo Used space is $used_space
echo Unused space is $unused_space
echo Space to free is $space_to_free

printf "Part 2: %d\n" "$(awk -v space_to_free="$space_to_free" '$2 >= space_to_free { print $2 }' /tmp/aoc_2022_day_7_files_totals_uniq  | sort | head -n1 | sed 's/^0*//')"
housekeep
