require './talon'

File.open("data/talon-data.js", 'w') do |file|
  file.puts "var exports = module.exports;"
  10.times do |i|
    cipher = Talon.new
    cipher.shuffle!
    file.puts "// #{cipher.to_s}"
    10.times do |j|
      values = []
      100.times do |k|
        values << cipher.next
      end
      file.puts "var array#{i}#{j} = [#{values.join(',')}];"
    end
    arrays = (1..9).to_a.map { |e| "array#{i}#{e}" }.join(',')
    file.puts "var array#{i} = array#{i}0.concat(#{arrays});"
    file.puts "exports.array#{i} = array#{i};"
  end
  arrays = (1..9).to_a.map { |e| "array#{e}" }.join(',')
  file.puts "var array = array0.concat(#{arrays});"
  file.puts "exports.array = array;"
end
