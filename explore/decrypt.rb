require './original'

LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')

deck = Deck.new

cipher = ARGV.join(' ')
cipher = cipher.upcase.gsub(/[^A-Z]/,'')
puts cipher.scan(/.{1,5}/).join(' ')
cipher = cipher.scan(/./).map {|e| LETTERS.index(e) }
plain = []
cipher.each do |p|
  plain << LETTERS[(p - deck.next) % 26]
end
puts plain.join('').scan(/.{1,5}/).join(' ')