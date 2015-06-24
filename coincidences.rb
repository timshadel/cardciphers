require './coder'
require './solitaire'
require './talon'

cipher = Talon.new # Solitaire.new

last = -1
count = 0
times = 100_000.0
(1..times).each do |i|
  n = cipher.next
  if n == last
    count += 1
  end
  last = n
end
puts count
puts times
puts count / times
puts 1 / 52.0
