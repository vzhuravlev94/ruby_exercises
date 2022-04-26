puts "Как тебя зовут?"
name = gets.chomp

puts "Какой у тебя рост?"
height = gets.to_i

perfect_weight = ( height - 110 ) * 1.15

if perfect_weight > 0
	puts "#{name}, здравствуйте! Ваш оптимальный вес - #{perfect_weight}!"
else 
	puts "Ваш вес уже оптимальный!"
end