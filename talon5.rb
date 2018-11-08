require './deck'
require './coder'
require './cipher'

class Talon5
  include Cipher

  def initialize discardIndex, deck=Deck.new
    @discardIndex = discardIndex - 1
    @deck = deck
  end

  def step1 max
    0.upto([max, 4].min) do |pile|
      @deck.discard pile
    end
  end

  def unstep1
    # TODO
  end

  def step2 max
    remaining = @deck.totalCount - max
    piles = @deck.discards.length - 1
    0.upto(piles) do |n|
      count = @deck.top_of_pile_face(n) - 1
      if (count > @deck.discards[n].count && @deck.length > remaining)
        @deck.discard n
      end
    end
    puts self.inspect
    puts max
    puts @deck.length
    puts remaining
    puts @deck.totalCount - @deck.length
    @deck.totalCount - @deck.length
  end

  def unstep2
    # TODO
  end

  def step3
    0.upto(@deck.discards.length-1) do |i|
      @deck.gather i
    end
  end

  def unstep3
    # TODO
  end

  def output
    # @deck[(@deck.first + @deck.last) % 52]
    @deck[index - 1]
  end

  def index
    @index ||= @deck.first
  end

  def process
    totalDiscards = @deck[@discardIndex]
    while totalDiscards > 0
      totalDiscards -= subprocess(totalDiscards)
    end
    output
  end

  def subprocess max
    step1 max
    step2 max
    discardCount = @deck.totalCount - @deck.length
    puts @deck.to_discard_s
    puts
    step3
    discardCount
  end

  def unprocess
    # TODO
  end

  def iv items
    # TODO
  end

end


cipher = Talon5.new 7
puts cipher
3.times { cipher.next }
puts cipher