require './original'

PLAINCODE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789+-/:()$&@".,?!\'%'.split('')
CRYPTCODE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('')

deck = Deck.new

key = ARGV[0]
plain = ARGV[1..-1].join(' ')
plain = plain.upcase.gsub(/[^A-Z0-9+\-\/\:\(\)\$\&\@\"\.\,\?\!\'\%]/,'')
puts plain.scan(/.{1,5}/).join(' ')
plain = plain.scan(/./).map {|e| PLAINCODE.index(e) }
extra = plain.count % 5
if extra > 0
  (0..(5 - extra - 1)).each {
    plain << 23
  }
end
cipher = []

key = key.upcase.gsub(/[^A-Z0-9+\-\/\:\(\)\$\&\@\"\.\,\?\!\'\%]/,'')
deck.key key.scan(/./).map {|e| PLAINCODE.index(e) }
plain.each do |p|
  k = deck.next52
  # puts k
  cipher << CRYPTCODE[(p + k) % 52]
end
puts cipher.join('').scan(/.{1,5}/).join(' ')