module Steps

  module Advance
    def advance card
      index = @cards.index card
      if index == @cards.length - 1
        @cards.delete_at index
        @cards.insert 1, card
      else
        @cards[index], @cards[index+1] = @cards[index+1], @cards[index]
      end
    end

    def unadvance card
      index = @cards.index card
      if index == 1
        @cards.delete_at index
        @cards.insert @cards.length, card
      else
        @cards[index], @cards[index-1] = @cards[index-1], @cards[index]
      end
    end
  end

  module TripleCut
    def triple_cut x, y
      little = @cards.index x
      big = @cards.index y
      first = [little, big].min
      second = [little, big].max
      top = @cards.slice! 0, first
      bottom = @cards.slice! (second - first + 1)..-1
      @cards = bottom + @cards + top
    end

    def untriple_cut x, y
      triple_cut x, y
    end
  end

  module StandardCut
    def cut length
      top = @cards.slice! 0, length
      @cards.insert -1, *top
    end

    def uncut length
      top = @cards.slice! @cards.length-length, length
      @cards.insert 0, *top
    end
  end

  module CountCut
    def count_cut length
      top = @cards.slice! 0, length
      @cards.insert -2, *top
    end

    def uncount_cut length
      top = @cards.slice! @cards.length-length-1, length
      @cards.insert 0, *top
    end
  end

  module Discard
    def discard pile
      @discards[pile] ||= []
      @discards[pile].unshift @cards.shift
    end

    def undiscard pile
      @cards.unshift @discards[pile].shift
    end
  end

  module Gather
    def gather pile
      while @discards[pile].count > 0
        @cards.push @discards[pile].shift
      end
    end

    def ungather pile
      self.face(-1).times do
        @discards[pile].unshift @cards.pop
      end
    end
  end

  module TopGather
    def topgather pile
      while @discards[pile].count > 0
        @cards.unshift @discards[pile].pop
      end
    end

    def untopgather pile
      # TODO: broken
      self.face(-1).times do
        @discards[pile].push @cards.shift
      end
    end
  end

  module DiscardFill
    def fill pile
      count = top_of_pile_face(pile) - 1
      count.times {
        discard pile
      }
    end

    def unfill pile
      count = @discards[pile].count - 1
      count.times do
        undiscard pile
      end
    end
  end

  module HorizontalFill
    def hfill pile
      0.upto(pile) do |n|
        count = top_of_pile_face(n) - 1
        if (count > @discards[n].count)
          discard n
        end
      end
    end

    def unhfill pile
      count = @discards[pile].count - 1
      count.times do
        undiscard pile
      end
    end
  end

  module InvertedCountCut
    def inverted_count_cut length
      top = @cards.slice! 0, length
      top.reverse!
      @cards.insert -2, *top
    end

    def uninverted_count_cut length
      top = @cards.slice! @cards.length-length-1, length
      top.reverse!
      @cards.insert 0, *top
    end
  end

end

class Deck
  include Steps::Advance
  include Steps::TripleCut
  include Steps::CountCut
  include Steps::StandardCut
  include Steps::Discard
  include Steps::Gather
  include Steps::TopGather
  include Steps::DiscardFill
  include Steps::HorizontalFill
  include Steps::InvertedCountCut

  NAMES = %w{AC 2C 3C 4C 5C 6C 7C 8C 9C TC JC QC KC AD 2D 3D 4D 5D 6D 7D 8D 9D TD JD QD KD AH 2H 3H 4H 5H 6H 7H 8H 9H TH JH QH KH AS 2S 3S 4S 5S 6S 7S 8S 9S TS JS QS KS}
  SUITS = %w{00 01 10 11}

  def initialize opts=:none
    @cards = Array(1..52)
    @cards = @cards + ['A','B'] if opts == :use_jokers
    @discards = []
  end

  def shuffle!
    @cards.shuffle!
  end

  def length
    @cards.length
  end

  def first
    self[0]
  end

  def last
    self[-1]
  end

  def [] index
    value = @cards[index]
    value = 53 if value == 'A' || value == 'B'
    value
  end

  def face index
    self[index] % 13
  end

  def suit index
    (self[index] - 1) / 13
  end

  def top_of_pile index
    value = @discards[index].last
    value = 53 if value == 'A' || value == 'B'
    value
  end

  def top_of_pile_face index
    (top_of_pile(index) - 1) % 13 + 1
  end

  def to_s
    str = @cards.map{|e| NAMES[e-1]}.join(' ')
    # @discards.each do |pile|
    #   str += "\n- #{pile.to_s}"
    # end
    str
  end

  def to_suits
    str = @cards.map { |i| SUITS[(i-1)/13] }.join('').scan(/../).join(' ')
    str
  end

end
