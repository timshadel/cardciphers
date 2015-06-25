require 'descriptive_statistics'
require './coder'
require './solitaire'
require './talon'
require './cycle'

cipher = Talon.new # Solitaire.new
# cipher.iv Coder.encode("random")

positions = {}
runs = 40
(1..runs).each do |run|
  counts = {}
  times = 100_000.0
  cipher.shuffle!
  (1..times).each do |i|
    n = cipher.next
    counts[n] ||= 0
    counts[n] = counts[n] + 1
  end
  # expected = times / 52.0

  # Counts by number
  # counts.keys.sort.each do |num|
  #   count = counts[num]
  #   puts "#{num}: #{count}"
  # end

  counts.to_a.map { |h,k| [k, h] }.sort.reverse.each_with_index do |entry, rank|
    value = entry[1]
    positions[value] ||= []
    positions[value] << rank
  end
end

m2 = []
positions.keys.sort.each do |num|
  pos = positions[num]
  avg = pos.mean
  stddev = pos.standard_deviation
  m2 << avg
  puts "#{num}: #{avg} (#{stddev})"
end
puts "Overall: #{m2.mean} (#{m2.standard_deviation})"
