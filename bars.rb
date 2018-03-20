#!/usr/bin/env ruby

data = {}

filename = ARGV[0]

File.open(filename, 'r').each do |line|
  k, v = line.split(',')
  data[k.to_i] = v.to_f
end

min = data.keys.sort.first
max = data.keys.sort.last
max_value = data.values.sort.last

(min..max).each do |s|
  data[s] = 0.0 if data[s].nil?

  if data[s] == 0.0
    bars = 0
  else
    bars = data[s] / max_value * 70
    bars = 1 if bars < 1.0
  end

  puts '%3d : (%8d) %s' % [s, data[s], '*' * bars]
end
