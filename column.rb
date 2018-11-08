class Column

    def initialize keyword
        @keyword = keyword
        @encryptKey = @keyword.split('').each_with_index.map { |l,i| "#{l}#{i}" }
        @decryptKey = @encryptKey.sort
    end

    def encrypt message
        columns = Hash.new {|h,k| h[k] = Array.new }
        message.split('').each_with_index do |l, i|
            keyIndex = i % @encryptKey.length
            columns[@encryptKey[keyIndex]] << l
        end
        ciphertext = ""
        @decryptKey.each do |column|
            ciphertext << columns[column].join('')
        end
        ciphertext
    end

    def decrypt ciphertext
        columns = Hash.new {|h,k| h[k] = Array.new }
        ciphertext.split('').each_with_index do |l, i|
            keyIndex = i % @decryptKey.length
            columns[@decryptKey[keyIndex]] << l
        end
        plaintext = ""
        @encryptKey.each do |column|
            plaintext << columns[column].join('')
        end
        plaintext
    end

end
