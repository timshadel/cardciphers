require './deck'
require './coder'

class Talon

  def initialize deck=Deck.new
    @deck = deck
  end

  def step1
    @deck.discard 0
    @deck.discard 1
    @deck.discard 2
    @deck.discard 3
  end

  def unstep1
    @deck.undiscard 3
    @deck.undiscard 2
    @deck.undiscard 1
    @deck.undiscard 0
  end

  def step2
    (0..3).each do |i|
      @deck.fill i
    end
  end

  def unstep2
    3.downto(0).each do |i|
      @deck.unfill i
    end
  end

  def step3
    (0..3).each do |i|
      @deck.gather i
    end
  end

  def unstep3
    3.downto(0).each do |i|
      @deck.ungather i
    end
  end

  def output
    @deck[@deck.first - 1]
  end

  def process
    step1
    step2
    step3
    output
  end

  def unprocess
    unstep3
    unstep2
    unstep1
    output
  end

  def iv items
    items.each do |i|
      process
      @deck.inverted_count_cut i
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
