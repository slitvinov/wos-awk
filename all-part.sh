#! /bin/bash

awk -f iosparser.awk nanopart/*.txt   | grep Russia | sort | awk -v title="Russia" -f tohtml.awk > russia.html
