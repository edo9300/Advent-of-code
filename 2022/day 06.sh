#!/bin/sh

matched_chars=""
char_1=""
char_2=""
char_3=""
char_4=""

put_new_char() {
	matched_chars="$matched_chars$char_1"
	char_1=$char_2
	char_2=$char_3
	char_3=$char_4
	char_4=$1
}

print_match() {
	#-1 as echo also puts a newline
	echo "start-of-packet marker detected after $(($(echo $matched_chars$char_1$char_2$char_3$char_4 | wc -m) - 1)) characters"
}

are_at_least_all_set() {
	[ -n "$char_1" ] && [ -n "$char_2" ] && [ -n "$char_3" ] && [ -n "$char_4" ]
}

check_chars() {
	are_at_least_all_set && [ "$char_1" != "$char_2" ] && [ "$char_1" != "$char_3" ] && [ "$char_1" != "$char_4" ] && [ "$char_2" != "$char_3" ] && [ "$char_2" != "$char_4" ] && [ "$char_3" != "$char_4" ]
}

while read -r chars; do
	for char in $chars; do
		put_new_char $char
		# check_chars
		if check_chars; then
			break 2
		fi
	done
	echo Not Found
	exit 1
done <<EOF
$(sed -e 's/./& /g' input6.txt)
EOF

print_match