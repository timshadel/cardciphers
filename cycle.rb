require './deck'
require './coder'

class Cycle

  def initialize deck=Deck.new
    @deck = deck
  end

  def step1
    @deck.discard 0
    @deck.gather 0
  end

  def unstep1
    @deck.ungather 0
    @deck.undiscard 0
  end

  def output
    @deck[@deck.first - 1]
  end

  def process
    step1
    output
  end

  def unprocess
    unstep1
    output
  end

  def iv items
    items.each do |i|
      process
      # @deck.inverted_count_cut i
    end
  end

  def guarantee &block
    begin
      n = yield
    end while n == 53
    n
  end

  def next
    guarantee { self.process }
  end

  def prev
    guarantee { self.unprocess }
  end

  def to_s
    @deck.to_s
  end

end
