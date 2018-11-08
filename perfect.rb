require './deck'
require './coder'
require './cipher'

class Perfect
  include Cipher

  def initialize deck=Deck.new
    @deck = deck
  end

  def step1
    @deck.discard 0
    @deck.discard 1
    @deck.discard 2
    @deck.discard 3
    @deck.discard 4
    @deck.discard 5
    @deck.discard 6

    @deck.discard 2

    2.times { @deck.discard 3 }
    4.times { @deck.discard 4 }
    7.times { @deck.discard 5 }
    12.times { @deck.discard 6 }
  end

  def step2
    # fib = [1, 1, 2, 3, 5, 8, 13]
    # fib.each_with_index do |count, i|
    #   (1..count).each do
    #     @deck.discard i
    #   end
    # end
  end

  def step3
    (0..6).each do |i|
      @deck.topgather i
    end
  end

  def step4
    (0..16).each do |i|
      @deck.discard 0
      @deck.discard 1
      @deck.discard 2
    end
  end

  def step5 round
    piles = [2, 1, 0]
    (0..round-1).each do
      piles.push piles.shift
    end
    piles.each do |i|
      @deck.gather i
    end
  end

  def output
    # result = []
    # (1..16).each do |i|
    #     result.push @deck.suit(i)
    # end
    # result.map { |e| e.to_s }.join("")

    # @deck.to_suits[13..20]
    
    a = @deck.to_suits.split(' ')
    [a[1], a[2], a[3], a[5], a[8], a[13], a[21], a[34]].map {|e| e.to_i(2)}.join('')


    # (0..3).each do |i|
    #   result.push (@deck.suit(i*4+1)) * 64 + @deck.suit(i*4+2) * 16 + (@deck.suit(i*4+3)) * 4 + @deck.suit(i*4+4)
    # end
    # result.map { |e| e.to_s(16) }.join("")
  end

  def process
    (0..2).each do |i|
        @deck.shuffle!
        # step1
        # step2
        # step3
        # step4
        # step5 i
    end
    output
  end

  def unprocess
    unstep5
    unstep4
    unstep3
    unstep2
    unstep1
    output
  end

end

# cipher = Perfect.new
# puts cipher.output
# exit 0


counts = {}
runs = 5
run_size = 100_000
items_per_run = 8
buckets = 4
expected = runs*run_size*items_per_run
(1..runs).each do |run|
  cipher = Perfect.new
#   cipher.shuffle!
  (1..buckets*run_size).each do |i|
    items = cipher.next.scan(/./)
    items.each do |n|
        counts[n] ||= 0
        counts[n] = counts[n] + 1
    end
  end
end
sum = 0
counts.keys.sort.each do |num|
  count = counts[num]
  error = count-expected
  sq_error = error * error * 1.0
  value = sq_error / expected
  sum += value
  puts "#{num},#{count},#{expected},#{error},#{sq_error},#{value}"
end
puts sum
