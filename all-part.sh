#! /bin/bash

output=russia.html
awk -f iosparser.awk -v field=C1 -v reg=Switz nanopart/*.txt   | \
    sort | awk -v title="Russia+Switz" -f tohtml.awk > ${output}

printf "created: %s\n" ${output} > "/dev/stderr"
