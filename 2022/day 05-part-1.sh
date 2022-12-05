#!/bin/sh

#We assume we got 9 columns max, so variables will go 1 to 9
total_columns=0
parsing_movements=0
parse_next_box_row() {
	if [ "$1" = "1" ]; then
		parsing_movements=1
		return 1
	fi
	total_columns=$#
	if [ "$1" != "~" ]; then
		column_1="$column_1 $1"
	fi
	if [ "$2" != "~" ]; then
		column_2="$column_2 $2"
	fi
	if [ "$3" != "~" ]; then
		column_3="$column_3 $3"
	fi
	if [ "$4" != "~" ]; then
		column_4="$column_4 $4"
	fi
	if [ "$5" != "~" ]; then
		column_5="$column_5 $5"
	fi
	if [ "$6" != "~" ]; then
		column_6="$column_6 $6"
	fi
	if [ "$7" != "~" ]; then
		column_7="$column_7 $7"
	fi
	if [ "$8" != "~" ]; then
		column_8="$column_8 $8"
	fi
	if [ "$9" != "~" ]; then
		column_9="$column_9 $9"
	fi
	return 0
}

cur_column=""
get_boxes_for_column() {
	if [ $1 -eq 1 ]; then
		cur_column="$column_1"
	elif [ $1 -eq 2 ]; then
		cur_column="$column_2"
	elif [ $1 -eq 3 ]; then
		cur_column="$column_3"
	elif [ $1 -eq 4 ]; then
		cur_column="$column_4"
	elif [ $1 -eq 5 ]; then
		cur_column="$column_5"
	elif [ $1 -eq 6 ]; then
		cur_column="$column_6"
	elif [ $1 -eq 7 ]; then
		cur_column="$column_7"
	elif [ $1 -eq 8 ]; then
		cur_column="$column_8"
	elif [ $1 -eq 9 ]; then
		cur_column="$column_9"
	fi
}

set_boxes_for_column() {
	if [ $1 -eq 1 ]; then
		column_1="$2"
	elif [ $1 -eq 2 ]; then
		column_2="$2"
	elif [ $1 -eq 3 ]; then
		column_3="$2"
	elif [ $1 -eq 4 ]; then
		column_4="$2"
	elif [ $1 -eq 5 ]; then
		column_5="$2"
	elif [ $1 -eq 6 ]; then
		column_6="$2"
	elif [ $1 -eq 7 ]; then
		column_7="$2"
	elif [ $1 -eq 8 ]; then
		column_8="$2"
	elif [ $1 -eq 9 ]; then
		column_9="$2"
	fi
}

add_to_column() {
	if [ $1 -eq 1 ]; then
		column_1="$2 $column_1"
	elif [ $1 -eq 2 ]; then
		column_2="$2 $column_2"
	elif [ $1 -eq 3 ]; then
		column_3="$2 $column_3"
	elif [ $1 -eq 4 ]; then
		column_4="$2 $column_4"
	elif [ $1 -eq 5 ]; then
		column_5="$2 $column_5"
	elif [ $1 -eq 6 ]; then
		column_6="$2 $column_6"
	elif [ $1 -eq 7 ]; then
		column_7="$2 $column_7"
	elif [ $1 -eq 8 ]; then
		column_8="$2 $column_8"
	elif [ $1 -eq 9 ]; then
		column_9="$2 $column_9"
	fi
}

take_n_boxes_from_column_n_and_put_them_in_column_m() {
	N=$1
	source_column=$2
	target_column=$3
	get_boxes_for_column $source_column
	new_column=""
	to_add_column=""
	for box in $cur_column; do
		if [ $N -eq 0 ]; then
			new_column="$new_column $box"
		else
			to_add_column="$box $to_add_column"
			N=$((N - 1))
		fi
	done
	set_boxes_for_column $source_column "$new_column"
	add_to_column $target_column "$to_add_column"
}

#move N from SOURCE to DESTINATION
parse_movement() {
	# echo "Moving $2 box(es) from $4 to $6"
	take_n_boxes_from_column_n_and_put_them_in_column_m $2 $4 $6
}

print_columns() {
	echo Final Column State

	print_top_of_column $column_1
	print_top_of_column $column_2
	print_top_of_column $column_3
	print_top_of_column $column_4
	print_top_of_column $column_5
	print_top_of_column $column_6
	print_top_of_column $column_7
	print_top_of_column $column_8
	print_top_of_column $column_9
	echo
}

print_top_of_column() {
	printf %s $1
}

while read -r line; do
	if [ $parsing_movements -eq 1 ]; then
		if [ -z "$line" ]; then
			continue
		fi
		parse_movement $line
	else
		parse_next_box_row $line
	fi
done << EOF
$(sed -e 's/    / \[~\]/g' -e 's/[^a-zA-Z0-9~]/ /g' input5.txt)
EOF
print_columns