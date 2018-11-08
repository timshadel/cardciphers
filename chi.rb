require './coder'
require './solitaire'
require './talon'
require './double'
require './cycle'

# cipher = Talon.new # Solitaire.new
# cipher.shuffle!
# cipher.iv Coder.encode("something7ish")

counts = {}
runs = 1_000
run_size = 20
expected = runs*run_size
(1..runs).each do |run|
  cipher = DoublePointers.new # Talon.new # Solitaire.new
  cipher.shuffle!
  (1..52*run_size).each do |i|
    n = cipher.next
    counts[n] ||= 0
    counts[n] = counts[n] + 1
  end
end
sum = 0
counts.keys.sort.each do |num|
  count = counts[num]
  error = count-expected
  sq_error = error * error * 1.0
  value = sq_error / expected
  sum += value
  puts "#{num},#{count},#{expected},#{error},#{sq_error},#{value}"
end
puts sum