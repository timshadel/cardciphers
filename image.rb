require 'chunky_png'
require './coder'
require './solitaire'
require './talon'

cipher = Solitaire.new

def quadrant n
  (n - 1) % 4
end

def top_bottom n
  q = quadrant(n)
  q == 2 || q == 3
end

def even_odd n
  q = quadrant(n)
  q == 1 || q == 3
end

def split_segment n
  q = quadrant(n)
  q == 0 || q == 3
end

size = 512
png = ChunkyPNG::Image.new(size, size, ChunkyPNG::Color('black'))
0.upto(size-1) do |y|
  0.upto(size-1) do |x|
    if split_segment(cipher.next)
      png[x,y] = ChunkyPNG::Color('white')
    end
  end
end
png.save('filename.png', :interlace => true)
