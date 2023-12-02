#!/bin/sh

cat ./test | \
    sed -E 's/^[^0-9]*([0-9]).*([0-9])[^0-9]*$/\1\2/g' |   `# only keep first and last digit if there are two or more digit in the line` \
    sed -E 's/^[^0-9]*([0-9])[^0-9]*$/\1\1/g' |   `# only keep the single digit but duplicate it if there is only one digit in the line` \
    paste -sd+ |   `# put everything in one line separated by '+'` \
    bc  # calculate the sum

