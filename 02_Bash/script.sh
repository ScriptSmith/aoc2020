#!/bin/bash

input="input.txt"

total1=0
total2=0

while IFS= read -r line
do
  splitLine=$(echo -n "$line" | sed 's/^\([0-9]*\)-\([0-9]*\)\s\([a-z]*\):\s\([a-z]*\).*$/\1 \2 \3 \4/')

  firstNum=$(echo -n "$splitLine" | cut -d " " -f1)
  secondNum=$(echo -n "$splitLine" | cut -d " " -f2)
  searchChar=$(echo -n "$splitLine" | cut -d " " -f3)
  password=$(echo -n "$splitLine" | cut -d " " -f4)

  # https://stackoverflow.com/a/16679640/
  filterChars="${password//[^$searchChar]}"
  countChars=$(echo -n $filterChars | wc -c)

  expression1="$countChars >= $firstNum & $countChars <= $secondNum"
  valid=$(expr $expression1)

  total1=$(( $total1 + $valid ))

  firstChar=${password:$(($firstNum - 1)):1}
  secondChar=${password:$(($secondNum - 1)):1}

  [ "$firstChar" = "$searchChar" ]
  firstMatches=$?

  [ "$secondChar" = "$searchChar" ]
  secondMatches=$?

  xorMatches=$(echo -n $(($firstMatches ^ $secondMatches)))
  total2=$(( $total2 + $xorMatches ))

  echo "$password $firstNum $secondNum $firstChar $secondChar"
  
done < "$input"

echo $total1
echo $total2