require './coder'
require './solitaire'
require './talon'

key = Coder.encode(ARGV[0])
plain = ARGV[1..-1].join(' ')

cipher = Talon.new # Solitaire.new
cipher.iv key
plain = Coder.plain plain
puts plain
plain = Coder.encode plain
ciphertext = []
plain.each do |p|
  k = cipher.next
  ciphertext << (p + k) % 52
end
encrypted = Coder.cryptcode ciphertext
puts encrypted