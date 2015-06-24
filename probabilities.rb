require './coder'
require './solitaire'
require './talon'
require './cycle'

cipher = Cycle.new # Solitaire.new
cipher.iv Coder.encode("random")

counts = {}
times = 100_000.0
(1..times).each do |i|
  n = cipher.next
  counts[n] ||= 0
  counts[n] = counts[n] + 1
end
expected = times / 52.0
counts.keys.sort.each do |num|
  count = counts[num]
  puts "#{num}: #{count} (#{count/expected - 1})"
end