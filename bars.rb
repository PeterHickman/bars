#!/usr/bin/env ruby

# Usage:
# ./bars.rb --file data.csv --key 0 --value 1 --width 80
#
# key and value refer to the columns in the input file and
# start from 0 (because I am a programmer)
#
# width is optional and defaults to 70

VALID_FLAGS = %w(file key value width)

def opts(list)
  data = {}
  new_list = []

  while list.any?
    item = list.shift
    if item.index('--') == 0
      k = item[2..-1].downcase

      raise "Unknown option #{item}" unless VALID_FLAGS.include?(k)

      raise "No data following the #{item} option" unless list.any?

      data[k] = list.shift
    else
      new_list << item
    end
  end

  return data, new_list
end

def int(flags, key, default = nil)
  if flags.key?(key)
    flags[key].to_i
  elsif default
    default
  else
    raise "Required option --#{key} <integer> missing"
  end
end

def str(flags, key, name)
  if flags.key?(key)
    flags[key]
  else
    raise "Required option --#{key} <#{name}> missing"
  end
end

flags, the_rest = opts(ARGV)

filename = str(flags, 'file', 'filename')
key      = int(flags, 'key')
value    = int(flags, 'value')
width    = int(flags, 'width', 70)

if the_rest.any?
  raise "Superfluous extra arguments #{the_rest.inspect}"
end

data = {}

File.open(filename, 'r').each do |line|
  x = line.split(',')
  data[x[key].to_i] = x[value].to_f
end

min = data.keys.sort.first
max = data.keys.sort.last
max_value = data.values.sort.last

(min..max).each do |s|
  data[s] = 0.0 if data[s].nil?

  if data[s] == 0.0
    bars = 0
  else
    bars = data[s] / max_value * width
    bars = 1 if bars < 1.0
  end

  puts '%3d : (%8d) %s' % [s, data[s], '*' * bars]
end
