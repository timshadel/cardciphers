require './deck'
require './coder'
require './cipher'

class DoublePointers
  include Cipher

  def initialize deck=Deck.new
    @deck = deck
  end

  def process
    pull = (@deck.first + @deck[@deck.first % @deck.length]) % @deck.length
    @deck.cut pull
    output = @deck.discard 0
    value = output.first
    @deck.uncut pull
    @deck.bringToFront (@deck.length - 1)
    card = @deck.first
    pull.times { @deck.advance card }
    adv = @deck[(pull + 1) % @deck.length]
    @deck.cut (pull + 1 + adv) % @deck.length
    another = @deck.first % @deck.length
    @deck.cut another
    @deck.discard 1
    @deck.gather 0
    @deck.uncut another
    @deck.uncut (pull + 1 + adv + 1) % @deck.length
    @deck.gather 1
    @deck.uncut 1
    value
  end

  def unprocess
    # pull = (d.first + d[d.first]) % d.length
    # d.cut pull
    # output = d.discard 0
    # value = output.first
    # d.uncut pull
    # pull.times { d.advance card }
    # adv = d[pull + 1]
    # d.cut (pull + 1 + adv) % d.length
    # d.discard 1
    # d.gather 0
    # d.uncut (pull + 1 + adv + 1) % d.length
    # d.gather 1
    # d.uncut 1
    # value
  end

end
