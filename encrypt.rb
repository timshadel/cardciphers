require './coder'
require './solitaire'
require './talon'

# key = Coder.uncryptcode(ARGV[0])
plain = ARGV[0..-1].join(' ')

cipher = Talon.new # Solitaire.new
# cipher.iv key
clean = Coder.plain plain
puts clean
plain = Coder.encode plain
sum = []
ciphertext = []
keystream = []
plain.each do |p|
  k = cipher.next
  keystream << k
  # puts "(#{k} + #{p}) % 52 = #{(p + k) % 52}"
  sum << (p + k)
  ciphertext << (p + k) % 52
end
puts plain.join("\t")
puts keystream.join("\t")
puts sum.join("\t")
puts ciphertext.join("\t")

encrypted = Coder.cryptcode ciphertext
puts encrypted