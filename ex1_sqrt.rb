puts "Введите переменную a"
a = gets.to_f
puts "Введите переменную b"
b = gets.to_f

puts "Введите переменную c"
c = gets.to_f
d = b**2 - 4 * a * c

if d > 0
	d_sqrt = Math.sqrt(d)
	x1 = (-b + d_sqrt) / (2 * a)
	x2 = (-b - d_sqrt) / (2 * a)
	puts "Дискриминант = #{d}, корень x1 = #{x1}, корень x2 = #{x2}"
elsif d == 0
	x = -b / (2 * a)
	puts "Дискриминант = #{d}, а корень x1 = x2 = #{x}"
else
	puts "Корней нет"
end
