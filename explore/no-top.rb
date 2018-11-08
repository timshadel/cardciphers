
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

  def step1
    advance 'A'
  end

  def step2
    advance 'B'
    advance 'B'
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

  def step4
    length = @cards.last
    length = 53 if length == 'A' || length == 'B'
    top = @cards.slice! 0, length
    @cards.insert -2, *top
  end

  def output
    length = @cards.first
    length = 53 if length == 'A' || length == 'B'
    @cards[length]
  end

  def process
    step1
    step2
    step3
    step4
    output
  end

  def next
    n = self.process
    n = self.process if n == 'A' || n == 'B'
    n
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
  if n == last
    count += 1
  end
  last = n
end

puts count
puts count / times
puts 1 / 26.0
puts 1 / 22.5