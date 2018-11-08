require './base52'

class ElsieFour

    def initialize key
        pass = key.split('')
        @key = []
        @index = {}
        4.times do |i|
            @key[i] = []
            13.times do |j|
                value = pass.shift
                @key[i][j] = value
                @index[value] = [i, j]
            end
        end
        @marker = letter_at([0, 0])
    end

    def letter_at index
        row = index[0] % @key.length
        col = index[1] % @key[0].length
        @key[row][col]
    end

    def offset_for letter
        place = Base52::ALPHABET.index letter
        [place / @key.length, place % @key.length]
    end

    def add index, offset
        row = (index[0] + offset[0]) % @key.length
        col = (index[1] + offset[1]) % @key[0].length
        [row, col]
    end

    def shift_row row
        value = @key[row].shift
        @key[row].push value
        @key[row].each_with_index do |letter, col|
            @index[letter] = [row, col]
        end
        self
    end

    def shift_col col
        prev_val = @key[-1][col]
        @key.length.times do |row|
            prev_row = (row - 1) % @key.length
            val = @key[row][col]
            @key[row][col] = prev_val
            @index[prev_val] = [row, col]
            prev_val = val
        end
        self
    end

    def encrypt message
        message = Base52.filter(message)
        ciphertext = message.split('').map do |letter|
            p_index = @index[letter]
            m_offset = offset_for(@marker)
            c_index = add(p_index, m_offset)
            cipherletter = letter_at(c_index)
            shift_row p_index[0]
            shift_col c_index[1]
            # Marker may have moved
            m_index = @index[@marker]
            c_offset = offset_for(cipherletter)
            next_index = add(m_index, c_offset)
            @marker = letter_at(next_index)
            cipherletter
        end.join('')
    end

    def decrypt ciphertext
        ciphertext = Base52.filter(ciphertext)
        message = ciphertext.split('').map do |cipherletter|
            c_index = @index[cipherletter]
            m_offset = offset_for(@marker).map { |e| e * -1 }
            p_index = add(c_index, m_offset)
            letter = letter_at(p_index)
            shift_row p_index[0]
            shift_col c_index[1]
            # Marker may have moved
            m_index = @index[@marker]
            c_offset = offset_for(cipherletter)
            next_index = add(m_index, c_offset)
            @marker = letter_at(next_index)
            letter
        end.join('')
    end

end
