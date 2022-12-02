#!/bin/sh

sum_string() {
	total=0
	for line in $(echo "$1"  | tr "," " "); do
		total=$((total + line))
	done
}

for line in $(echo $(awk -v RS= -v ORS=':' '1' input1.txt) | tr " " "," | tr ":" " "); do
	sum_string "$line"
	total_calories="${total_calories} ${total}"
done

last_three_sorted=$(echo "$total_calories" | tr " " "\n" | sort -rg | head -n 3)

single_high=$(echo "$last_three_sorted" | tr " " "\n" | head -n 1)
sum_string "$last_three_sorted"
last_three_total=$total

echo "Single elf carrying the higest calories count is carrying ${single_high}"
echo "Last three elves carrying the higest calories count are carrying ${last_three_total}"
