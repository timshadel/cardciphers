require './base52'

class OneWayPlayfair

    def initialize key
        numbers = key.split('')
        root = Math.sqrt(numbers.length)
        rows = root.floor
        columns = rows
        if root > columns
            columns = columns + 1
        end
        cells = rows * columns
        empty = cells - numbers.length
        extra = rows - empty
        @index = {}
        @key = []
        rows.times do |i|
            @key[i] = []
            columns.times do |j|
                if j == columns - 1 && empty > 0 && i >= extra
                    @key[i][j] = nil
                else
                    number = numbers.shift
                    @key[i][j] = number
                    @index[number] = [i, j]
                end
            end
        end
    end

    def encrypt message
        message = message.gsub(/(.)\1/, '\1X\1') if is_key_square
        groups = (message + "X").scan(/../)
        ciphertext = groups.map do |group|
            index1 = @index[group[0]]
            index2 = @index[group[1]]
            left = index2
            right = index1
            if index1 == index2
                left = next_col index1
                right = next_row index2
            elsif index1[0] == index2[0]
                left = next_col index1
                right = next_col index2
            elsif index1[1] == index2[1]
                left = next_row index1
                right = next_row index2
            elsif is_extra(index1) || is_extra(index2)
                left = next_col index1
                right = next_col index2
            else
                left = [index1[0], index2[1]]
                right = [index2[0], index1[1]]
            end
            [value(left), value(right)].join('')
        end.join('')
    end

    def paired_encrypt first, second
        length = [first.length, second.length].min
        mixed = ""
        left = first.split('')
        right = second.split('')
        length.times do
            mixed << left.shift
            mixed << right.shift
        end
        combined = self.encrypt(mixed).split('')
        a = ""
        b = ""
        length.times do
            a << combined.shift
            b << combined.shift
        end
        [a, b]
    end

    def next_row index
        row = index[0]
        col = index[1]
        loop do
            row = (row + 1) % @key.length
            value = @key[row][col]
            break if !value.nil?
        end
        [row, col]
    end

    def next_col index
        row = index[0]
        col = index[1]
        loop do
            col = (col + 1) % @key[row].length
            value = @key[row][col]
            break if !value.nil?
        end
        [row, col]
    end

    def prev_row index
        row = index[0]
        col = index[1]
        loop do
            row = (row - 1) % @key.length
            value = @key[row][col]
            break if !value.nil?
        end
        [row, col]
    end

    def prev_col index
        row = index[0]
        col = index[1]
        loop do
            col = (col - 1) % @key[row].length
            value = @key[row][col]
            break if !value.nil?
        end
        [row, col]
    end

    def is_extra index
        bottom_row = [@key.length - 1, index[1]]
        return !value(index).nil? && value(bottom_row).nil?
    end

    def is_empty index
        return value(index).nil?
    end

    def is_key_square
        return @key.length == @key[0].length
    end

    def value index
        row = index[0]
        col = index[1]
        @key[row][col]
    end

    def decrypt ciphertext
        if !is_key_square
            return "Key is not square. Cannot be decrypted."
        end

        groups = ciphertext.scan(/../)
        message = groups.map do |group|
            index1 = @index[group[0]]
            index2 = @index[group[1]]
            left = index2
            right = index1
            if index1[0] == index2[0]
                left = prev_col index1
                right = prev_col index2
            elsif index1[1] == index2[1]
                left = prev_row index1
                right = prev_row index2
            else
                left = [index1[0], index2[1]]
                right = [index2[0], index1[1]]
            end
            [value(left), value(right)].join('')
        end.join('')
    end

end
