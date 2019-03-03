primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101]
letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*<>-=+:/?".split('')
temp = letters.dup

sorted = []
while temp.count > 0
    primes.each do |p|
        index = p % temp.count
        index = (temp.count % 2 == 0) ? -1*index : index - 1
        sorted << temp.delete_at(index)
        break if temp.count == 0
    end
end

indexed = sorted.map { |e| letters.index(e) }

tempCols = *(0...13)
columns = []
while tempCols.count > 0
    primes.each do |p|
        index = p % tempCols.count
        index = (tempCols.count % 2 == 0) ? index - 1 : -1*index
        columns << tempCols.delete_at(index)
        break if tempCols.count == 0
    end
end

alternate = []
columns.each do |c|
    0.upto(3) do |r|
        alternate << sorted[r*13 + c]
    end
end

puts " " + (0...13).map { |e| columns.index(e).to_s(16) }.join(' ')
puts " " + sorted[0...13].join(' ') + "   " + alternate[0...13].join(' ')
puts " " + sorted[13...26].join(' ') + "   " + alternate[13...26].join(' ')
puts " " + sorted[26...39].join(' ') + "   " + alternate[26...39].join(' ')
puts " " + sorted[39...52].join(' ') + "   " + alternate[39...52].join(' ')
puts



def diff left, right
    between = (left - right).abs
    around = [left, right].min + (51 - [left, right].max)
    [between, around].min * 1.0
end

diff = []
indexed.each_with_index do |index, n|
    letter = sorted[n]
    left = diff(indexed[(n-1) % indexed.count], indexed[n])
    right = diff(indexed[n], indexed[(n+1) % indexed.count])
    up = diff(indexed[(n-13) % indexed.count], indexed[n])
    down = diff(indexed[n], indexed[(n+13) % indexed.count])
    avg_diff = [left, right, up, down].inject(0) { |sum, i| sum + i } / 4
    diff << avg_diff
end

diffCount = diff.count * 1.0
puts diff[0...13].map{ |e| "%05.2f" % e }.join(',')
puts diff[13...26].map{ |e| "%05.2f" % e }.join(',')
puts diff[26...39].map{ |e| "%05.2f" % e }.join(',')
puts diff[39...52].map{ |e| "%05.2f" % e }.join(',')
puts diff.inject { |sum, i| sum + i } / diffCount
diff_sort = diff.sort
puts "#{diff_sort[13]}, #{diff_sort[25]}, #{diff_sort[38]}  #{diff_sort[38] - diff_sort[13]}"
puts "#{diff_sort.first} (#{sorted[diff.index(diff_sort.first)]}), #{diff_sort.last}"

# puts primes.join(',')
# puts primes.to_enum.with_index.map { |e, i| e % (52 - i) }.join(',')
# puts primes.to_enum.with_index.map { |e, i| e % (26 - i) }.join(',')
