#!/bin/sh
# shellcheck disable=SC2002

tmpfile="/tmp/sed_addition_$(date +%s%N)" # reasonable to assume this is a unique filename not used by any other program

cat - > "$tmpfile"

while grep -qsE '[0-9F] *\+ *[s0-9]' "$tmpfile"; do
    cat "$tmpfile" | \
        sed -E 's/([0-9]+) *\+ *([0-9]+)/f#\1F+s#\2S/g' | \
        sed -E ':a;s/(f[0-9]*)#([0-9])([0-9]*F\+s[0-9]*)#([0-9])([0-9]*S)/\1\2#\3\4#\5/g;ta' | \
        sed -E 's/f([0-9]+)#F\+s([0-9]+)#([0-9]+)S/f\2\3F+s\1S/g' | \
        sed -E 's/#//g' | \
        sed -E 's/f([0-9]*)F\+s([0-9]*)S/f0\1@F+s\2@S/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)9@/i@\1F+s\28@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)8@/i@\1F+s\27@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)7@/i@\1F+s\26@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)6@/i@\1F+s\25@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)5@/i@\1F+s\24@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)4@/i@\1F+s\23@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)3@/i@\1F+s\22@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)2@/i@\1F+s\21@/g' | \
        sed -E 's/@([0-9]*)F\+s([0-9]*)1@/i@\1F+s\20@/g' | \
        sed -E 's/0i/1/g' | \
        sed -E 's/1i/2/g' | \
        sed -E 's/2i/3/g' | \
        sed -E 's/3i/4/g' | \
        sed -E 's/4i/5/g' | \
        sed -E 's/5i/6/g' | \
        sed -E 's/6i/7/g' | \
        sed -E 's/7i/8/g' | \
        sed -E 's/8i/9/g' | \
        sed -E 's/9i/i0/g' | \
        sed -E 's/([0-9])@([0-9]*F\+s[0-9]*)0@/@\1\2@0/g' | \
        sed -E 's/f0*(([1-9][0-9]*)?)@([0-9]*)F\+s@0*S/\1\3/g' | \
        cat - > "${tmpfile}_new" && mv "${tmpfile}_new" "$tmpfile"
done

cat "$tmpfile"
rm "$tmpfile"

