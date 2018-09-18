lines = IO.readlines("aes-sbox.txt")
final = []
count = 0
lines.each do |l|
    line = l.chomp
    if line.length > 0
        bytes = line.split(",")
        line = bytes.map { |e| '"' + e.to_i(16).to_s(4).rjust(4, "0") + '"' }.join(",")
        final[count] ||= []
        final[count].push(line)
        count += 1
    else
        if count == 32
            count = 0
        end
    end
end

final.each do |list|
    puts list.join(",,")
end
