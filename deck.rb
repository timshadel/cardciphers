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
  include Steps::Discard
  include Steps::Gather
  include Steps::DiscardFill
  include Steps::InvertedCountCut

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

  def top_of_pile index
    value = @discards[index].first
    value = 53 if value == 'A' || value == 'B'
    value
  end

  def top_of_pile_face index
    top_of_pile(index) % 13
  end

  def to_s
    str = @cards.to_s
    @discards.each do |pile|
      str += "\n- #{pile.to_s}"
    end
    str
  end

end
