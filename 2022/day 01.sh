#!/bin/sh

sum_string() { 
	total=0
	for line in $(echo "$1"  | tr "," " "); do
		total=$((total + line))
	done
	echo $total
}

for line in $(echo $(echo $1 | awk -v RS= -v ORS=':' '1' input1.txt) | tr " " "," | tr ":" " "); do
	tot=$(sum_string "$line")
	total_calories="${total_calories} ${tot}"
done

last_three_sorted=$(echo "$total_calories" | tr " " "\n" | sort -rg | head -n 3)

single_high=$(echo "$last_three_sorted" | tr " " "\n" | head -n 1)
last_three_total=$(sum_string "$last_three_sorted")

echo "Single elf carrying the higest calories count is carrying ${single_high}"
echo "Last three elves carrying the higest calories count are carrying ${last_three_total}"
