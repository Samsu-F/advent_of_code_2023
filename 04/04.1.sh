#!/bin/sh
# shellcheck disable=SC2002


sed -E 's/$/ R/' ./input | \
    sed -E 's/ ([0-9])\b/0\1/g' > ./tmp

while grep -qsE '\| [0-9]' ./tmp; do
    cat ./tmp | \
        sed -E 's/ ([0-9]+)(( [0-9]+)* \| )\1 / \1\2M /' | \
        sed -E 's/\| [0-9]+ /| /' | \
        sed -E 's/M ([0-9 ]*)R/\1RI/' | \
        cat - > ./tmp_new && mv ./tmp_new ./tmp
done

cat ./tmp | \
    sed -E 's/^.*R//' | \
    sed -E 's/^I(I*)$/(1\1)/' | \
    sed -E 's/I/\*2/g' | \
    sed -E 's/\(1\)/1/' | \
    sed -E 's/^$/0/' | \
    paste -sd+ | \
    ../mul_sum_regex.sh



rm ./tmp
