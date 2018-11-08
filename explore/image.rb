require 'chunky_png'

size = 256
png = ChunkyPNG::Image.new(size, size, ChunkyPNG::Color('black'))
0.upto(size-1) do |y|
  0.upto(size-1) do |x|
    if rand(2) == 1
      png[x,y] = ChunkyPNG::Color('white')
    end
  end
end
png.save('filename.png', :interlace => true)
