months = {
  "January" => 31,
	"February" => 28,
  "March" => 31,
	"April" => 30,
  "May" => 31,
  "June" => 30,
  "July" => 31,
  "August" => 31,
  "September" => 30,
  "October" => 31,
  "November" => 30,
  "December" => 31
}

months.each do |key, value| puts key + ": " + value.to_s if value == 30
end
