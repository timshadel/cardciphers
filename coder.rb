module Coder

  PLAINCODE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@#$%&()-=+:,./? '.split('')
  CRYPTCODE = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('')

  def self.filter plain
    encoded = plain.upcase.gsub(/[^A-Z0-9\@\#\$\%\&\(\)\-\=\+\:\,\.\/\? ]/,'')
    # extra = encoded.length % 5
    # if extra > 0
    #   (0..(5 - extra - 1)).each {
    #     encoded << 'X'
    #   }
    # end
    encoded
  end

  def self.plain plain
    filtered = self.filter plain
    filtered.scan(/.{1,5}/).join(' ')
  end

  def self.encode plain
    filtered = self.filter plain
    filtered.upcase.scan(/./).map {|e| PLAINCODE.index(e) + 1 }
  end

  def self.decode numbers
    numbers.map {|e| PLAINCODE[e - 1] }.join('').scan(/.{1,5}/).join(' ')
  end

  def self.cryptcode numbers
    numbers.map {|e| CRYPTCODE[e - 1] }.join('').scan(/.{1,5}/).join(' ')
  end

  def self.uncryptcode message
    message.gsub(' ', '').scan(/./).map {|e| CRYPTCODE.index(e) + 1}
  end

end
