#!/bin/sh

printf "Part 1 "
awk 'BEGIN {FS=""}{for(i=1; i<=NF-4; i++) { unq=0; delete seen; for (j=i+0; j<i+4; j++){ if (!seen[$j]++) unq++;} if(unq > 3) {print i+3; exit 123;}}}' input6.txt
printf "Part 2 "
awk 'BEGIN {FS=""}{for(i=1; i<=NF-14; i++) { unq=0; delete seen; for (j=i+0; j<i+14; j++){ if (!seen[$j]++) unq++;} if(unq > 13) {print i+13; exit 123;}}}' input6.txt