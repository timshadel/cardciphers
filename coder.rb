module Coder

  PLAINCODE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%&()-=+:,./?'.split('')
  CRYPTCODE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('')

  def self.plain plain
    encoded = plain.upcase.gsub(/[^A-Z0-9+\-\/\:\(\)\$\&\@\"\.\,\?\!\'\%]/,'')
    extra = encoded.length % 5
    if extra > 0
      (0..(5 - extra - 1)).each {
        encoded << 'Z'
      }
    end
    encoded.scan(/.{1,5}/).join(' ')
  end

  def self.encode plain
    plain.upcase.gsub(' ', '').scan(/./).map {|e| PLAINCODE.index(e) }
  end

  def self.decode numbers
    numbers.map {|e| PLAINCODE[e] }.join('').scan(/.{1,5}/).join(' ')
  end

  def self.cryptcode numbers
    numbers.map {|e| CRYPTCODE[e] }.join('').scan(/.{1,5}/).join(' ')
  end

  def self.uncryptcode message
    message.gsub(' ', '').scan(/./).map {|e| CRYPTCODE.index(e) }
  end

end
