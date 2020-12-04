#!/usr/bin/awk -f
BEGIN { NF=NF; RS=""; FS="[ \n]" }
/ecl:/&&/pid:/&&/eyr:/&&/hcl:/&&/byr:/&&/iyr:/&&/hgt:/ { c++ }
END { print c }
