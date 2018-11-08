require './base52'

class Vignere

    def initialize keys
        @keys = keys.map { |key| Base52.to_numbers(key) }
        reset
    end

    def reset
        @index = 0
    end

    def keystream i
        keys = []
        i.times { keys.push(next_key) }
        Base52.to_symbols(keys)
    end

    def next_key
        sum = @keys.inject(0) { |sum, key| sum + key[@index % key.length] }
        @index += 1
        sum
    end

    def encrypt message
        numbers = Base52.to_numbers message
        math = numbers.map do |num|
            key = next_key
            (num + key) % Base52::ALPHABET.length
        end
        Base52.to_symbols(math)
    end

    def decrypt message
        numbers = Base52.to_numbers message
        math = numbers.map do |num|
            key = next_key
            (num - key) % Base52::ALPHABET.length
        end
        Base52.to_symbols(math)
    end

end
