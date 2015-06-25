module Cipher

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

  def shuffle!
    @deck.shuffle!
  end

end
