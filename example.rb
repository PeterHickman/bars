#!/usr/bin/env ruby

# How many times do you have to roll a dice before you
# have rolled 6 ten times?

def process
  count = 0
  rolls = 0

  loop do
    rolls += 1

    count += 1 if rand(6) == 5

    break if count == 10
  end

  rolls
end

data = Hash.new(0.0)

100_000.times do
  data[process] += 1.0
end

data.each do |k, v|
  puts "#{k},#{v}"
end
