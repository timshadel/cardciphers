lines = IO.readlines("eff_large_wordlist.txt")
lines.each do |l|
    line = l.chomp
    index, word = line.split(/\s+/)
    w = word.gsub(/[rstlnaeiou-]/,'')
    next unless w.length > 1
    puts "#{index}\t#{w}\t#{word}"
end
