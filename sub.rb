require './caesar'
require './handkdf'
require './playfair'
require './vignere'
require './lc4'
require './base52'
require './stefanov_shi'

message = <<-HEREDOC
Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.

Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this.

But, in a larger sense, we can not dedicate—we can not consecrate—we can not hallow—this ground. The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us—that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion—that we here highly resolve that these dead shall not have died in vain—that this nation, under God, shall have a new birth of freedom—and that government of the people, by the people, for the people, shall not perish from the earth.
HEREDOC

caesar = Caeser.new 17
numbers = caesar.decode message
ciphernumbers = caesar.encrypt numbers
0.upto(52) do |i|
    if ciphernumbers.index(i).nil?
        ciphernumbers << i
    end
end

File.open("data/caesar-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end

eff_vignere = ['perfectly', 'cornhusk', 'hardly', 'unroasted'].join('')
eff_morphic = ['decompose', 'raft', 'overlord', 'headboards'].join('')

mine_vignere = ['by', 'every', 'word', 'that', 'proceedeth', 'forth', 'from', 'the', 'mouth', 'of', 'god'].join('')
mine_morphic = ['charity', 'never', 'fails', 'any', 'walk', 'the', 'path'].join('')

long_vignere = mine_vignere
long_morphic = mine_morphic

pass_vignere = [ long_vignere[0..6], long_vignere[7..17], long_vignere[18..30] ]
pass_morphic = [ long_morphic[0..6], long_morphic[7..19], long_morphic[20..30] ]

morph = Homomorphic.new pass_morphic[0], pass_morphic[1]
ciphertext = morph.encrypt message
ciphernumbers = Base52.to_numbers ciphertext

File.open("data/morph-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end

v = Vignere.new pass_vignere
ciphertext = v.encrypt message
ciphernumbers = Base52.to_numbers ciphertext

File.open("data/v-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end

col1 = Column.new pass_morphic[0]
col2 = Column.new pass_morphic[1]
# playpass = col2.encrypt(col1.encrypt(Base52::ALPHABET))
playpass = Base52::ALPHABET.split('').shuffle.join('')
playfair = OneWayPlayfair.new playpass
clean_message = Base52.filter(message)
ciphertext = playfair.encrypt clean_message
ciphernumbers = Base52.to_numbers(ciphertext)

File.open("data/playfair-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end

morph = Homomorphic.new pass_morphic[0], pass_morphic[1]
mv_pass = pass_vignere.map { |p| morph.encrypt(p) }
v = Vignere.new mv_pass
ciphertext = v.encrypt message
ciphernumbers = Base52.to_numbers ciphertext

File.open("data/mv-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end


morph = Homomorphic.new pass_morphic[0], pass_morphic[1]
mv_pass = pass_vignere.map { |p| morph.encrypt(p) }
v = Vignere.new mv_pass
ciphertext = v.encrypt message
ciphernumbers = Base52.to_numbers ciphertext

col1 = Column.new pass_morphic[0]
col2 = Column.new pass_morphic[1]
col3 = Column.new pass_morphic[2]
playpass = col3.encrypt(col2.encrypt(col1.encrypt(Base52::ALPHABET)))
intermediate = Base52.to_symbols(ciphernumbers)
playfair = OneWayPlayfair.new playpass
ciphertext = playfair.encrypt(intermediate)
ciphernumbers = Base52.to_numbers(ciphertext)

File.open("data/mvp-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end


puts "MVPR"
puts
morph = Homomorphic.new pass_morphic[0], pass_morphic[1]
mv_pass = ['byevery', 'wordthatpro'].map { |p| morph.encrypt(p) }
v = Vignere.new mv_pass
triple_combination = v.encrypt( (morph.encrypt('ceedethforthf') * 3)[0..30] )
puts triple_combination

col1 = Column.new pass_morphic[0]
col2 = Column.new pass_morphic[1]
col3 = Column.new pass_morphic[2]
# playpass = col3.encrypt(col2.encrypt(col1.encrypt(Base52::ALPHABET)))
# playpass = Base52::ALPHABET.split('').shuffle.join('')
playfair = OneWayPlayfair.new playpass
full_random = Base52.to_symbols([49, 31, 4, 33, 16, 51, 27, 2, 44, 5, 10, 47, 15, 21, 3, 31, 48])

r1 = triple_combination.split('')
r2 = (full_random * 2)[0..30].split('')
mixed_random = ""
31.times do
    mixed_random << r1.shift
    mixed_random << r2.shift
end
puts mixed_random

random_pass = playfair.encrypt(mixed_random)
final_pass = [ random_pass[0..6], random_pass[7..17], random_pass[18..30], full_random ]
puts final_pass

v = Vignere.new final_pass 
ciphertext = v.encrypt message
ciphernumbers = Base52.to_numbers ciphertext

File.open("data/mvpr-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end


v4_pass = pass_vignere.map { |p| morph.encrypt(p) }
v4_pass << full_random
v = Vignere.new v4_pass
ciphertext = v.encrypt message
ciphernumbers = Base52.to_numbers ciphertext

File.open("data/v4-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end


puts "JOURNAL"
puts

# Step 1: 40+ char passphrase
# Step 2: Mix 17 chars of random data into it. Use 2nd pass for double column mix.
mixed_pass = full_random[0..7] + long_vignere[0..7] + full_random[8..15] + long_vignere[8..15] + full_random[16..-1] + long_vignere[16..-1]
mixed_pass = mixed_pass.upcase
col1 = Column.new pass_morphic[0]
col2 = Column.new pass_morphic[1]
mixed_pass = col2.encrypt(col1.encrypt(mixed_pass))
# Step 3: First 31 chars are keying key, the rest after is plaintext
# TODO: (well, should I largest prime length? That's not what the journal said. Check.) 
primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
section = primes.first
primes.each do |n|
    if mixed_pass.length - 31 > n
        section = n
    end
end
# Step 3a: first 31 chars are pass
pass_vignere = [ mixed_pass[0..6], mixed_pass[7..17], mixed_pass[18..30] ]
# Step 3b: the rest are plaintext, but repeat them enough for a PRP
plain = mixed_pass[31..-1][0..section-1]
repeats = (104.0 / plain.length).ceil + 1 # 104 == 52 * 2, since that seems to be enough to sort a deck

v = Vignere.new pass_vignere
ciphertext = v.encrypt (plain * repeats)
ciphernumbers = Base52.to_numbers ciphertext
cipherLength = ciphernumbers.length
# Step 3c: Shuffle a 52-char Playfair table
sorter = StefanovShi.new Base52::ALPHABET
playpass, stream = sorter.sort(ciphernumbers)
usedLength = cipherLength - stream.length
playfair = OneWayPlayfair.new playpass

# Step 4: Use the triple combination + left over key material (plain) in the shuffled Playfair
v = Vignere.new [ mixed_pass[0..6], mixed_pass[7..17] ]
third = mixed_pass[18..30]
threepeats = (cipherLength / third.length).ceil
ciphertext = v.encrypt (third * threepeats)
triple_combination = ciphertext[usedLength..usedLength+30]
puts triple_combination

# Step 4b: Generate 31 chars
r1 = triple_combination.split('')
r2 = (plain * repeats)[usedLength..usedLength+30].split('')
puts r2.join('')
unusedPlain = (plain * repeats)[usedLength..usedLength+30]
a, b = playfair.paired_encrypt(triple_combination, unusedPlain)

v = Vignere.new [a]
random_pass = v.encrypt b
final_pass = [ random_pass[0..6], random_pass[7..17], random_pass[18..30] ]
puts final_pass
puts full_random

triple_key = Vignere.new final_pass
iv = full_random
ciphertext = ""
tag = ""
msg = Base52.filter(message)
msg_index = 0
while msg_index < msg.length
    a, b = playfair.paired_encrypt(triple_key.keystream(iv.length), iv)
    puts "ROUND #{msg_index}"
    puts iv
    puts a
    puts b
    va = Vignere.new [a]
    vb = Vignere.new [b]
    snippet = msg[msg_index..-1][0..iv.length-1]
    puts snippet
    ea = va.encrypt(snippet)
    eb = vb.encrypt(snippet)
    puts ea
    puts eb
    iv = eb
    ciphertext << ea
    tag = eb[-6..-1]
    msg_index += iv.length
end
puts "FINAL"
puts ciphertext
puts tag
ciphernumbers = Base52.to_numbers(ciphertext)

File.open("data/journal-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end




lc4_iv = "/QPEWJ"
elsie = ElsieFour.new playpass # Base52::ALPHABET
elsie.encrypt lc4_iv
ciphertext = elsie.encrypt message
ciphernumbers = Base52.to_numbers(ciphertext)

File.open("data/elsie-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end


def reallyRandom
    result = 63
    loop do
        result = rand(0..63)
        break if result < 52
    end
    result + 1
end

ciphernumbers = message.split('').map { |e| reallyRandom }
File.open("data/random-data.js", 'w') do |file|
    file.puts "var exports = module.exports;"
    file.puts "var array = [#{ciphernumbers.join(', ')}];"
    file.puts "exports.array = array;"
end
