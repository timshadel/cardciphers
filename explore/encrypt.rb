require './original'

LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')

deck = Deck.new

plain = ARGV.join(' ')
plain = plain.upcase.gsub(/[^A-Z]/,'')
puts plain.scan(/.{1,5}/).join(' ')
plain = plain.scan(/./).map {|e| LETTERS.index(e) }
extra = plain.count % 5
if extra > 0
  (0..(5 - extra - 1)).each {
    plain << 23
  }
end
cipher = []
plain.each do |p|
  cipher << LETTERS[(p + deck.next) % 26]
end
puts cipher.join('').scan(/.{1,5}/).join(' ')