#!/bin/sh
# shellcheck disable=SC2002


{ head -n2 ./input | sed -E 's/././g'; cat ./input; } > ./input_shifted_2
{ head -n1 ./input | sed -E 's/././g'; cat ./input; head -n1 ./input | sed -E 's/././g'; } > ./input_shifted_1
{ cat ./input; head -n2 ./input | sed -E 's/././g'; } > ./input_shifted_0

paste -dL ./input_shifted_2 ./input_shifted_1 ./input_shifted_0 | \
    head -n-1 | \
    tail -n+2 | \
    sed -E 's/(^|L)/\1X./g' | \
    sed -E 's/(L|$)/.\1/g' | \
    sed -E 's/[^0-9\*\.LX]/./g' > ./tmp

while grep -Eqs '[^X]L' ./tmp; do
    cat ./tmp | \
        sed -E 's/^([^XL]*[^0-9]([0-9]*X\.?[0-9]*)[^0-9][^XL]*L[^XL]*[^0-9]([0-9]*)X\*([0-9]*)[^0-9][^XL]*L[^XL]*[^0-9]([0-9]*X\.?[0-9]*)[^0-9][^L]*)$/\1G,\2,\3,\4,\5,G/g' | \
        sed -E 's/X([^LG])/\1X/g' | \
        cat - > ./tmp_new && mv ./tmp_new ./tmp
done


cat ./tmp | \
    sed -E 's/^[^G]*//g' | \
    sed -E 's/X//g' | \
    sed -E 's/\./,/g' | \
    sed -E 's/,+/,/g' | \
    sed -E 's/G(,[0-9]+){3,},G//g' | \
    sed -E 's/G(,[0-9]+){,1},G//g' | \
    sed -E 's/GG/G+G/g' | \
    sed -E 's/G,([0-9]+),([0-9]+),G/(\1*\2)/g' | \
    { tr -d '\n'; echo ''; } | \
    sed -E 's/\)\(/)+(/g' | \
    bc

rm ./tmp ./input_shifted_2 ./input_shifted_1 ./input_shifted_0
