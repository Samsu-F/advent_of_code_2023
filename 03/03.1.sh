#!/bin/sh
# shellcheck disable=SC2002


{ head -n2 ./input | sed -E 's/././g'; cat ./input; } > ./input_shifted_2
{ head -n1 ./input | sed -E 's/././g'; cat ./input; head -n1 ./input | sed -E 's/././g'; } > ./input_shifted_1
{ cat ./input; head -n2 ./input | sed -E 's/././g'; } > ./input_shifted_0

paste -dL ./input_shifted_2 ./input_shifted_1 ./input_shifted_0 | \
    head -n-1 | \
    tail -n+2 | \
    sed -E 's/(^|L)/\1X./g' | \
    sed -E 's/(L|$)/.\1/g' > ./tmp

while grep -Eqs '[^X]$' ./tmp; do
    cat ./tmp | \
        sed -E 's/^([^XL]*X[\.0-9]{6}[^XL]*)L([^XL]*X\.)[0-9]{4}(\.[^XL]*)L([^XL]*X[\.0-9]{6}[^XL]*)$/\1L\2....\3L\4/g' | \
        sed -E 's/^([^XL]*X[\.0-9]{5}[^XL]*)L([^XL]*X\.)[0-9]{3}(\.[^XL]*)L([^XL]*X[\.0-9]{5}[^XL]*)$/\1L\2...\3L\4/g' | \
        sed -E 's/^([^XL]*X[\.0-9]{4}[^XL]*)L([^XL]*X\.)[0-9]{2}(\.[^XL]*)L([^XL]*X[\.0-9]{4}[^XL]*)$/\1L\2..\3L\4/g' | \
        sed -E 's/^([^XL]*X[\.0-9]{3}[^XL]*)L([^XL]*X\.)[0-9]{1}(\.[^XL]*)L([^XL]*X[\.0-9]{3}[^XL]*)$/\1L\2.\3L\4/g' | \
        sed -E 's/X([^L])/\1X/g' | \
        cat - > ./tmp_new && mv ./tmp_new ./tmp
done

cat ./tmp | \
    sed -E 's/^[^XL]*XL/0/g' | \
    sed -E 's/XL[^XL]*X$/0/g' | \
    sed -E 's/[^0-9]/./g' | \
    sed -E 's/\.+/./g' | \
    sed -E 's/\./+/g' | \
    paste -sd+ | \
    ../sum_regex.sh

rm ./input_shifted_2 ./input_shifted_1 ./input_shifted_0 ./tmp
