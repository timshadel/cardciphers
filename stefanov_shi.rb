require './base52'

class StefanovShi

    def initialize letters
        @letters = letters.split('')
    end

    def sort keystream
        return [@letters.join(''), keystream] if @letters.length == 1

        @buckets = Hash.new {|h,k| h[k] = Array.new }
        @letters.each do |l|
            bucket = keystream.shift
            @buckets[bucket] << l
        end
        @buckets.keys.sort.each do |bucket|
            letters = @buckets[bucket]
            sorter = StefanovShi.new letters.join('')
            letters, keystream = sorter.sort(keystream)
            @buckets[bucket] = letters.split('')
        end
        sorted = @buckets.keys.sort.map do |bucket|
            @buckets[bucket].join('')
        end.join('')
        [sorted, keystream]
    end

end
