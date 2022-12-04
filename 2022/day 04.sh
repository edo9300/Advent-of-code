#!/bin/sh

is_fully_contained_in() {
	[ $1 -le $3 ] && [ $2 -ge $4 ]
}

check_full_overlap() {
	is_fully_contained_in $1 $2 $3 $4 || is_fully_contained_in $3 $4 $1 $2
}

is_partially_contained_in() {
	[ $2 -ge $3 ] && [ $1 -le $4 ]
}

check_partial_overlap() {
	is_partially_contained_in $1 $2 $3 $4 || is_partially_contained_in $3 $4 $1 $2
}

part_1=0
part_2=0
while read -r parsed_range; do
	if check_full_overlap $parsed_range; then
		part_1=$((part_1 + 1))
	fi
	if check_partial_overlap $parsed_range; then
		part_2=$((part_2 + 1))
	fi
done << EOF
$(sed 's/[-,]/ /g' input4.txt)
EOF

echo $part_1
echo $part_2