purchase = {}

loop do
  puts "Введите название товара:"
  name = gets.chomp
  break if name == "стоп"
  puts "Введите цену за единицу товара:"
  price = gets.to_f
  puts "Введите количество товара:"
  amount = gets.to_f
  purchase[name] = {price: price, amount: amount}
end

puts purchase
total_cost = 0

purchase.each do |name, price_amount|
  total_price = price_amount[:price] * price_amount[:price]
  puts "Итоговая сумма за товар #{name}: " + total_price.to_s
  total_cost += total_price

end

puts "Общая стоимость корзины : #{total_cost}"
