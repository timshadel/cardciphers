WHEEL16 = %w{ b c d f g h j k m p q v w x y z }
SCRABBLE16 = %w{ a b c d e g i l m n o p r s t u }

lines = IO.readlines("eff_large_wordlist.txt")
lines.each do |l|
    line = l.chomp
    index, word = line.split(/\s+/)
    # w = word.gsub(/[rstlnaeiou-]/,'')
    scrabble = word.downcase.gsub(/[^#{SCRABBLE16.join('')}]/,'')
    wheel = word.downcase.gsub(/[^#{WHEEL16.join('')}]/,'')
    next unless wheel.length > 1 || scrabble.length > 1
    scrabble = "-" if scrabble.length == 0
    wheel = "-" if wheel.length == 0
    puts "#{index}\t#{word}\t#{scrabble}\t#{wheel}"
end
