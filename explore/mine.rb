
class Deck

  def initialize
    @cards = Array(1..52)
    @a = rand(52)
    @b = rand(52)
    @cards.shuffle!
  end

  def step1
    @a = (@a + 1) % 52
  end

  def unstep1
    @a = @a - 1
    @a = @a + 52 if @a < 0
  end

  def step2
    @b = (@b + 2) % 52
  end

  def unstep2
    @b = @b - 2
    @b = @b + 52 if @b < 0
  end

  def triple_cut
    little = @a
    big = @b
    first = [little, big].min
    second = [little, big].max
    top = @cards.slice! 0, first
    bottom = @cards.slice! (second - first + 1)..-1
    @cards = bottom + @cards + top
    if @a == first
      @a = bottom.count
      @b = @a + (second - first)
    else
      @b = bottom.count
      @a = @b + (second - first)
    end
  end

  def step3
    triple_cut
  end

  def unstep3
    triple_cut
  end

  def step4
    length = @cards.last - 1
    top = @cards.slice! 0, length
    @cards.insert -2, *top
  end

  def unstep4
    length = @cards.last - 1
    top = @cards.slice! 52-length-1, length
    @cards.insert 0, *top
  end

  def output
    length = @cards.first - 1
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
    n = n - 26 if n > 26
    n
  end

  def unprocess
    unstep4
    unstep3
    unstep2
    unstep1
    output
  end

  def prev
    n = self.unprocess
    n = n - 26 if n > 26
    n
  end

  def reversible
    puts self
    step1
    step2
    step3
    step4
    puts self
    unstep4
    unstep3
    unstep2
    unstep1
    puts self
  end

  def to_s
    "#{@cards.to_s} :: #{@a}, #{@b}"
  end

end

d = Deck.new
# d.reversible
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