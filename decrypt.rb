require './coder'
require './solitaire'
require './talon'

key = Coder.uncryptcode(ARGV[0])
ciphertext = ARGV[1..-1].join(' ')

cipher = Talon.new # Solitaire.new
cipher.iv key
clean = ciphertext.gsub(' ', '')
puts clean
ciphertext = Coder.uncryptcode clean
plaintext = []
ciphertext.each do |p|
  k = cipher.next
  # puts "(#{k} + #{p}) % 52 = #{(p + k) % 52}"
  plaintext << (p - k) % 52
end
decrypted = Coder.decode plaintext
puts decrypted