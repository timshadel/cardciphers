require './fifty-two'

class Deck

  def next
    n = next52
    n = n - 26 if n > 26
    n
  end

  def prev
    n = prev52
    n = n - 26 if n > 26
    n
  end

end
