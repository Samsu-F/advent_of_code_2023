#!/bin/sh
# shellcheck disable=SC2002

tmpfile="/tmp/sed_mul_sum_$(date +%s%N)" # reasonable to assume this is a unique filename not used by any other program

# the absolute path of the directory of this script
script_dir_path="$(dirname "$(readlink -f "$0")")"

sed -E 's/\*/x/g' > "$tmpfile" # accept both * and x as multiplication symbol. Use x from now on because it doesn't need to be escaped

while grep -qE '[xX\+]|\([0-9]+\)' "$tmpfile"; do
    while grep -qsE '[0-9F] *x *[s0-9]|z|[0-9]{2}X' "$tmpfile"; do
        cat "$tmpfile" | \
            sed -E 's/([0-9]+) *x *([0-9]+)/\(f\1aFxs\2bS\)/g' | \
            sed -E 's/([0-9])a([0-9]*)Fxs([0-9]*)([0-9])b([0-9]*)S/\1a\2Fxs\3b\4\5S+\1z\2ZX\4z\5Z/g' | \
            sed -E 's/([0-9])a([0-9]*)Fxsb([0-9]*)S/a\1\2Fxs\3bS/g' | \
            sed -E 's/fa[0-9]*Fxs[0-9]*bS\+//g' | \
            sed -E 's/z[0-9]/0z/g' | \
            sed -E 's/zZ//g' | \
            sed -E 's/([0-9])0X([0-9])/\1X\20/g' | \
            sed -E 's/X0([0-9])/X\1/g' | \
            cat - > "${tmpfile}_new" && mv "${tmpfile}_new" "$tmpfile"
    done

    cat "$tmpfile" | \
        sed -E 's/\(([0-9]+)\)/\1/g' | \
        sed -E 's/0X[0-9]*/0/g' | \
        sed -E 's/[0-9]*X0/0/g' | \
        sed -E 's/1X|X1//g' | \
        sed -E 's/2X3|3X2/6/g' | \
        sed -E 's/2X4|4X2/8/g' | \
        sed -E 's/2X5|5X2/10/g' | \
        sed -E 's/2X6|6X2/12/g' | \
        sed -E 's/2X7|7X2/14/g' | \
        sed -E 's/2X8|8X2/16/g' | \
        sed -E 's/2X9|9X2/18/g' | \
        sed -E 's/3X4|4X3/12/g' | \
        sed -E 's/3X5|5X3/15/g' | \
        sed -E 's/3X6|6X3/18/g' | \
        sed -E 's/3X7|7X3/21/g' | \
        sed -E 's/3X8|8X3/24/g' | \
        sed -E 's/3X9|9X3/27/g' | \
        sed -E 's/4X5|5X4/20/g' | \
        sed -E 's/4X6|6X4/24/g' | \
        sed -E 's/4X7|7X4/28/g' | \
        sed -E 's/4X8|8X4/32/g' | \
        sed -E 's/4X9|9X4/36/g' | \
        sed -E 's/5X6|6X5/30/g' | \
        sed -E 's/5X7|7X5/35/g' | \
        sed -E 's/5X8|8X5/40/g' | \
        sed -E 's/5X9|9X5/45/g' | \
        sed -E 's/6X7|7X6/42/g' | \
        sed -E 's/6X8|8X6/48/g' | \
        sed -E 's/6X9|9X6/54/g' | \
        sed -E 's/7X8|8X7/56/g' | \
        sed -E 's/7X9|9X7/63/g' | \
        sed -E 's/8X9|9X8/72/g' | \
        sed -E 's/2X2/4/g' | \
        sed -E 's/3X3/9/g' | \
        sed -E 's/4X4/16/g' | \
        sed -E 's/5X5/25/g' | \
        sed -E 's/6X6/36/g' | \
        sed -E 's/7X7/49/g' | \
        sed -E 's/8X8/64/g' | \
        sed -E 's/9X9/81/g' | \
        "$script_dir_path"/sum_regex.sh | \
        cat - > "${tmpfile}_new" && mv "${tmpfile}_new" "$tmpfile"
done


cat "$tmpfile"
rm "$tmpfile"

