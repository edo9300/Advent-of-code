#!/bin/sh

counter=1
register=1
total=0

display=""

is_sprite_visible() {
	[ $((register - 1)) -le $(((counter - 1) % 40)) ] && [ $((register + 1)) -ge $(((counter - 1) % 40)) ]
}

increment_counter_and_check() {
	if [ $((counter % 40)) -eq 20 ]; then
		total=$((total + (counter * register)))
	fi
	if is_sprite_visible; then
		display="${display}#"
	else
		display="${display}."
	fi
	counter=$((counter + 1))
	if [ $((counter % 40)) -eq 1 ]; then
		display="${display};"
	fi
}

execute() {
	if [ "$1" = "noop" ]; then
		increment_counter_and_check
	else
		increment_counter_and_check
		increment_counter_and_check
		register=$((register + $2))
	fi
}

while read -r line || [ -n "$line" ]; do #Thing needed so that no newline is needed at the end of the input
	execute $line
done < input10.txt

echo $total
echo $display | tr ";" "\n"