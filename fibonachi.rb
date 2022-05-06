fibonachi_array = [0]
next_number = 1

while next_number < 100
  fibonachi_array << next_number
  next_number = fibonachi_array[-1] + fibonachi_array[-2]
end

puts fibonachi_array
