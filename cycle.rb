require './deck'
require './coder'
require './cipher'

class Cycle
  include Cipher

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

end
