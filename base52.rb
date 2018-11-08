module Base52

    ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*-=+:<>/?'
  
    def self.to_numbers message
        message.upcase.split('').map { |e| ALPHABET.index(e) || nil }.reject { |e| e.nil? }
    end

    def self.to_symbols numbers
        numbers.map { |n| n < ALPHABET.length ? ALPHABET[n] : nil }.reject{ |e| e.nil? }.join('')
    end

    def self.filter message
        to_symbols(to_numbers(message))
    end
  
end
