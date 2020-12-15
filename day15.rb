#!/usr/bin/env ruby
nums = {}
pos = 0
next_num = 0

[0,13,1,16,6,17].each do |num|
  next_num = nums.key?(num) ? pos - nums[num] : 0
  nums[num] = pos
  pos += 1
end

while pos < 2020 do
  num = next_num
  next_num = nums.key?(num) ? pos - nums[num] : 0
  nums[num] = pos
  pos += 1
end

puts num
