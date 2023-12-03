#!/bin/sh
# shellcheck disable=SC2002 # disable 'useless cat' warning

cat ./input | \
    grep -Ev '(1[3-9]|[2-9][0-9]|[1-9][0-9]{2,}) red' | \
    grep -Ev '(1[4-9]|[2-9][0-9]|[1-9][0-9]{2,}) green' | \
    grep -Ev '(1[5-9]|[2-9][0-9]|[1-9][0-9]{2,}) blue' | \
    grep -E --only-matching '^Game [0-9]+' | \
    grep -E --only-matching '[0-9]+' | \
    paste -sd+ | \
    ../sum_regex.sh
