require './base52'
require './column'

class Homomorphic

    # Alphabet twice. Remove Very end (V-Z), Eat So.
    INPUT = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ"

    def initialize pass1, pass2
        first = Column.new pass1
        second = Column.new pass2
        @letters = second.encrypt(first.encrypt(INPUT))
        0.upto(Base52::ALPHABET.length - 1) do |i|
            if Base52::ALPHABET[i] == @letters[i]
                puts "WARN: #{Base52::ALPHABET[i]} encrypts to itself."
            end
        end
        @password = Hash.new {|h,k| h[k] = Array.new }
        @letters.split('').each_with_index do |letter, index|
            @password[letter] << Base52::ALPHABET[index]
        end
    end

    def encrypt message
        Base52.filter(message).split('').map do |l|
            encrypt_one l
        end.join('')
    end

    def encrypt_one letter
        sub = @password[letter].shift
        @password[letter].push sub
        sub
    end

    def decrypt ciphertext
        Base52.filter(ciphertext).split('').map { |l| @letters[Base52::ALPHABET.index(l)] }.join('')
    end

end
