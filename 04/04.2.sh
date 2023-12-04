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
    sed -E 's/^Card *[0-9]+:.*R(.*)$/lIR\1L/' | \
    paste -sd '' | \
    cat - > ./tmp_new && mv ./tmp_new ./tmp


# time complexity of this is bad, for the given input it takes approximately 60 seconds on my machine :(
while grep -qsE 'n|RI' ./tmp; do
    cat ./tmp | \
        sed -E 's/l(I*)R(I*)IL/l\1R\2Ln\2,\1N/' | \
        sed -E 's/nI(I*),(I*)N(l[^L]*L)/\3n\1,\2N/g' | \
        sed -E 's/n,(I*)Nl/l\1/g' | \
        cat - > ./tmp_new && mv ./tmp_new ./tmp
done


cat ./tmp | \
    sed -E 's/[RlL]//g' | \
    sed -E 's/I{25000}/\+25000/g' `# this line is not necessary but it improves performance` | \
    sed -E 's/I{1000}/\+1000/g' `# this line is not necessary but it improves performance` | \
    sed -E 's/I{50}/\+50/g' `# this line is not necessary but it improves performance` | \
    sed -E 's/I/\+1/g' | \
    sed -E 's/^\++//' | \
    ../sum_regex.sh

rm ./tmp
