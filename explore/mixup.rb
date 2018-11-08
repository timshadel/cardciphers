
class Deck

  def initialize
    @cards = Array(1..52) + ['A','B']
    @cards.shuffle!
  end

  def advance joker
    index = @cards.index joker
    if index == 53
      @cards.delete_at index
      @cards.insert 1, joker
    else
      @cards[index], @cards[index+1] = @cards[index+1], @cards[index]
    end
  end

  def unadvance joker
    index = @cards.index joker
    if index == 1
      @cards.delete_at index
      @cards.insert 53, joker
    else
      @cards[index], @cards[index-1] = @cards[index-1], @cards[index]
    end
  end

  def step1
    advance 'A'
  end

  def unstep1
    unadvance 'A'
  end

  def step2
    advance 'B'
    advance 'B'
  end

  def unstep2
    unadvance 'B'
    unadvance 'B'
  end

  def step3
    little = @cards.index 'A'
    big = @cards.index 'B'
    first = [little, big].min
    second = [little, big].max
    top = @cards.slice! 0, first
    bottom = @cards.slice! (second - first + 1)..-1
    @cards = bottom + @cards + top
  end

  def unstep3
    step3
  end

  def step4
    length = @cards.last
    length = 53 if length == 'A' || length == 'B'
    top = @cards.slice! 0, length
    @cards.insert -2, *top
  end

  def unstep4
    length = @cards.last
    length = 53 if length == 'A' || length == 'B'
    top = @cards.slice! 54-length-1, length
    @cards.insert 0, *top
  end

  def output
    length = @cards.first
    length = 53 if length == 'A' || length == 'B'
    @cards[length]
  end

  def process
    step1
    step2
    step4
    step3
    output
  end

  def guarantee &block
    begin
      n = yield
    end while n == 'A' || n == 'B'
    n
  end

  def next
    n = guarantee { self.process }
    n = n - 26 if n > 26
    n
  end

  def unprocess
    unstep3
    unstep4
    unstep2
    unstep1
    output
  end

  def prev
    n = guarantee { self.unprocess }
    n = n - 26 if n > 26
    n
  end

  def reversible
    puts self
    step1
    step2
    step3
    puts self
    unstep3
    unstep2
    unstep1
    puts self
  end

  def to_s
    @cards.to_s
  end

end

d = Deck.new
last = -1
count = 0
times = 100_000.0
(1..times).each do |i|
  n = d.next
  # puts n
  if n == last
    count += 1
  end
  last = n
end

# (1..times-1).each do |i|
#   n = d.prev
#   puts n
# end

puts count
puts count / times
puts 1 / 26.0
puts 1 / 22.5
