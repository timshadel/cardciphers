require './deck'
require './coder'
require './cipher'

class Dealer
  include Cipher

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
    0.upto(3).each do |i|
      @deck.fill i
    end
    puts self.inspect
  end

  def unstep2
    3.downto(0).each do |i|
      @deck.unfill i
    end
  end

  def step3
    @deck.equalize
    puts self.inspect
  end

  def unstep3
    puts "BEFORE: #{self.inspect}"
    @deck.unequalize
    puts "AFTER : #{self.inspect}"
  end

  def step4
    (0..3).each do |i|
      @deck.gather i
    end
  end

  def unstep4
    3.downto(0).each do |i|
      @deck.ungatherFull i
    end
  end

  def output
    # @deck[(@deck.first + @deck.last) % 52]
    @deck[index - 1]
  end

  def index
    @index ||= @deck.first
  end

  def process previousPlaintext = nil
    if !previousPlaintext.nil?
      @deck.bringToFront previousPlaintext
    end
    step1
    step2
    step3
    step4
    output
  end

  def unprocess previousPlaintext = nil
    unstep4
    unstep3
    unstep2
    unstep1
    if !previousPlaintext.nil?
      @deck.unBringToFront previousPlaintext
    end
    output
  end

  def iv items
    items.each do |i|
      process
      k = (i + @deck.first) % 52
      @deck.cut k
    end
  end

end
