require './deck'
require './coder'
require './cipher'

class Solitaire
  include Cipher

  def initialize deck=Deck.new(:use_jokers)
    @deck = deck
  end

  def step1
    @deck.advance 'A'
  end

  def unstep1
    @deck.unadvance 'A'
  end

  def step2
    @deck.advance 'B'
    @deck.advance 'B'
  end

  def unstep2
    @deck.unadvance 'B'
    @deck.unadvance 'B'
  end

  def step3
    @deck.triple_cut 'A', 'B'
  end

  def unstep3
    @deck.triple_cut 'A', 'B'
  end

  def step4
    @deck.count_cut @deck.last
  end

  def unstep4
    @deck.uncount_cut @deck.last
  end

  def output
    @deck[@deck.first]
  end

  def process
    step1
    step2
    step3
    step4
    output
  end

  def unprocess
    unstep4
    unstep3
    unstep2
    unstep1
    output
  end

  def iv items
    items.each do |i|
      process
      @deck.count_cut i+1
    end
  end

end
