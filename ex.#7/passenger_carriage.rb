require_relative 'manufacturer_company'

class PassengerCarriage
  attr_reader :type, :number
  attr_accessor :seats, :occupied_seats
  include Manufacturer

  def initialize(seats, number = rand(0..99))
    @type = "passenger"
    @seats = seats.to_i
    @number = number
    @occupied_seats = 0
  end

  def take_seat
    if @seats > 0
      @seats -= 1 unless @seats == 0
      @occupied_seats += 1
    end
  end

  def show_occupied_seats
    puts "Количество занятых мест: #{@occupied_seats}"
  end

  def show_empty_seats
    puts "Количество свободных мест: #{@seats}"
  end
end
