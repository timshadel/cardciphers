require './deck'
require './aes_sbox'

class PassCode

    WHEEL16 = %w{ b c d f g h j k m p q v w x y z }
    SCRABBLE16 = %w{ a b c d e g i l m n o p r s t u }

    attr_reader :letters, :fours, :hex

    def initialize phrase, opts=:scrabble
        @list = opts == :wheel ? WHEEL16 : SCRABBLE16
        filtered = phrase.downcase.gsub(/[^#{@list.join('')}]/,'').split('')
        count = filtered.length / 16 * 16
        raise ArgumentError, "Password '#{filtered.join('')}' is too small." if count == 0
        @letters = filtered[0..count-1]
        @fours = @letters.map { |e| @list.index(e).to_s(4).rjust(2, "0") }.join('')
        @hex = @letters.map { |e| @list.index(e).to_s(16) }.join('')
    end

end

class Password

    def initialize phrase, opts=nil
        @passcode = PassCode.new phrase, opts
    end

    def rotate str
        lines = str.scan(/..../)
        rotated = []
        lines.each_with_index do |l, i|
            round = i % 4
            if round == 0
                rotated.push l
                next
            end
            line = l.split('')
            round.times { line.unshift line.pop }
            rotated.push line.join('')
        end
        rotated.join('')
    end

    def sub str
        str.scan(/..../).map { |e| AES_SBOX[e] }.join('')
    end

    def generate
        return nil if @passcode.fours.length == 0
        str = @passcode.fours
        puts str.scan(/..../).join(' ')
        full = ""
        while full.length < 220
            str = rotate(str)
            puts
            puts str.scan(/..../).join(' ')
            str = sub(str)
            puts
            puts str.scan(/..../).join(' ')
            full += str
        end
        full
    end

end

class Oracle

    def initialize list
        @unused = list.split('').map { |s| s.to_i }
        @used = []
    end

    def next
        current = @unused.shift
        @used.push current
        current
    end

    def to_s
        "Unused: #{@unused.join('')}\nUsed  : #{@used.join('')}"
    end

end

class StefanovShi

    attr :discards, :items, :result

    def initialize items, oracle
        @items = items
        @oracle = oracle
        @discards = {}
        # puts Deck.name(@items)
    end

    def discard pile
        @discards[pile] ||= []
        @discards[pile].unshift @items.shift
    end

    def shuffle
        while @items.length > 0
            index = @oracle.next
            discard(index)
        end
        result = []
        @discards.keys.sort.each do |pile|
            cards = @discards[pile]
            if cards.length == 1
                # puts "* #{Deck.name(cards)}"
                result << cards
                next
            end
            shuffler = StefanovShi.new cards, @oracle
            shuffler.shuffle
            result << shuffler.result
        end
        @result = result.flatten
        @discards = {}
    end

end

# code = PassCode.new "citable-grandpa-frighten-splashed-atypical-overplant"
# puts code.letters.join('')
# code = PassCode.new "citable-grandpa-frighten-splashed-atypical-overplant", :wheel
# code = PassCode.new "cit", :wheel
# puts code.letters.join('')
# exit 0

# pass = Password.new "citable-grandpa-frighten-splashed-atypical-overplant"
# full = pass.generate
# puts full
# pass = Password.new "citable-grandpa-frighten-splashed-atypical-overplant", :wheel
# pass = Password.new "cit", :wheel

code = PassCode.new "taekwondo-superman-tingle-numeral-makeover"
puts code.letters.join('')
pass = Password.new "taekwondo-superman-tingle-numeral-makeover"
full = pass.generate
puts full.scan(/..../).join(' ').scan(/..................../).join("\n")

oracle = Oracle.new full

shuffler = StefanovShi.new Array(1..52), oracle
shuffler.shuffle
puts shuffler.result.join(',')
puts Deck.name(shuffler.result)
