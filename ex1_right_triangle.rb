puts "Какая у треугольника длина стороны a?"
a = gets.to_f

puts "Какая у треугольника длина стороны b?"
b = gets.to_f

puts "Какая у треугольника длина стороны c?"
c = gets.to_f

if (c**2 == a**2 + b**2 || a**2 == b**2 + c**2 || b**2 == a**2 + c**2) && (a == b || a == c || b == c)
	puts "Это прямоугольный и равнобедренный треугольник!"
elsif c**2 == a**2 + b**2 || a**2 == b**2 + c**2 || b**2 == a**2 + c**2
	puts "Это прямоугольный треугольник!"
elsif (a == b && b == c && c == a) && (a == b || a == c || b == c)
	puts "Это равносторонний и равнобедренный треугольник"
elsif a == b || a == c || b == c
	puts "Это равнобедренный треугольник!"
else
	puts "Треугольник не прямоугольный!"
end
