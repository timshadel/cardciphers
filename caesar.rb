class Caeser

    ALPHABET="ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*-=+:<>/?"

    def initialize offset, count=52
        @offset = offset
        @count = count
    end

    def decode message
        message.upcase.split('').map { |e| ALPHABET.index(e) || nil }.reject { |e| e.nil? }
    end

    def encode numbers
        numbers.map { |n| ALPHABET[n] }.join('')
    end

    def encrypt numbers
        numbers.map { |num| (num + @offset) % @count }
    end

    def decrypt
        numbers.map { |num| (num - @offset) % @count }
    end

end
