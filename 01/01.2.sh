#!/bin/sh

cat ./input | \
    sed -E 's/one/o1e/g' |   `# replace spelled out digits without breaking overlapping words` \
    sed -E 's/two/t2o/g' | \
    sed -E 's/three/t3e/g' | \
    sed -E 's/four/4/g' | \
    sed -E 's/five/5e/g' | \
    sed -E 's/six/6/g' | \
    sed -E 's/seven/7n/g' | \
    sed -E 's/eight/e8t/g' | \
    sed -E 's/nine/n9e/g' | \
    sed -E 's/^[^0-9]*([0-9]).*([0-9])[^0-9]*$/\1\2/g' |   `# only keep first and last digit if there are two or more digit in the line` \
    sed -E 's/^[^0-9]*([0-9])[^0-9]*$/\1\1/g' |   `# only keep the single digit but duplicate it if there is only one digit in the line` \
    paste -sd+ |   `# put everything in one line separated by '+'` \
    ../sum_regex.sh  # calculate the sum
