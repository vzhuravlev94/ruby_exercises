puts "Введите число:"
date = gets.to_i

puts "Введите месяц:"
month = gets.to_i

puts "Введите год:"
year = gets.to_i

if year % 4 == 0 && year % 100 !=0
  february = 29
elsif year % 400 == 0
  february = 29
  else february = 28
end

days_in_months = [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
puts x = days_in_months[0...(month.to_i - 1)].sum + date.to_i
