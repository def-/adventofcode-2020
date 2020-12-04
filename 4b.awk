#!/usr/bin/awk -f
BEGIN { NF=NF; RS=""; FS="[ \n]" }
/ecl:/&&/pid:/&&/eyr:/&&/hcl:/&&/byr:/&&/iyr:/&&/hgt:/ {
  for(i = 1; i <= NF; ++i) {
    n = index($i, ":");
    key = substr($i, 1, n - 1)
    val = substr($i, n + 1)
    if (key == "byr" && (val < 1920 || val > 2002)) next
    if (key == "iyr" && (val < 2010 || val > 2020)) next
    if (key == "eyr" && (val < 2020 || val > 2030)) next
    if (key == "hcl" && !(val ~ /^#[0-9a-f]{6}$/)) next
    if (key == "ecl" && !(val ~ /^(amb|blu|brn|gry|grn|hzl|oth)$/)) next
    if (key == "pid" && !(val ~ /^[0-9]{9}$/)) next
    if (key == "hgt") {
      unit = substr(val, length(val) - 1)
      val = substr(val, 1, length(val) - 2)
      if (unit == "cm") {
        if (val < 150 || val > 193) next
      } else if (unit == "in") {
        if (val < 59 || val > 76) next
      } else {
        next
      }
    }
  }
  c++
}
END { print c }
