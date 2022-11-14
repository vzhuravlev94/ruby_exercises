require_relative 'manufacturer_company'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_accessor :number, :type, :speed, :route, :carriages_amount, :current_station

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/

  @@trains = {}

  def initialize(number)
    @number = number
    @speed = 0
    @type = type
    validate!
    @@trains[number] = self
    register_instance
  end

  def train_block(&block)
    @cargo_train_carriages.each { |cargo_carriage| yield(cargo_carriage) } if @type == "cargo"
    @passenger_train_carriages.each { |passenger_carriage| yield(passenger_carriage) } if @type == "passenger"
  end

  def count_carriages
    if @type == "cargo"
      @cargo_train_carriages.size
    else
      @passenger_train_carriages.size
    end
  end

  def validate!
    raise "Номер не может быть пустым" if @number.empty?
    raise "Номер неверного формата" if @number !~ NUMBER_FORMAT
  end

  def self.find(number)
    @@trains[number]
  end

  def speed_increase(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    route.first_station.accept_train(self)
  end

  def move_forward
    if next_station.accept_train(self)
      current_station.send_train(self)
      @current_station_index += 1
    end
  end

  def move_backward
    if previous_station.accept_train(self)
      current_station.send_train(self)
      @current_station_index -= 1
    end
  end

  # protected

  def current_station
    route.stations_list[@current_station_index]
  end

  def next_station
    route.stations_list[@current_station_index + 1]
  end

  def previous_station
    route.stations_list[@current_station_index - 1]
  end

  def add_cargo_carriage(cargo_carriage)
    if speed == 0 && cargo_carriage.kind_of?(CargoCarriage)
      @cargo_train_carriages << cargo_carriage
    end
  end

  def delete_cargo_carriage(cargo_carriage)
    if speed == 0
      @cargo_train_carriages.delete(cargo_carriage) if @cargo_train_carriages.include?(cargo_carriage)
    end
  end

  def add_passenger_carriage(passenger_carriage)
    if speed == 0 && passenger_carriage.kind_of?(PassengerCarriage)
      @passenger_train_carriages << passenger_carriage
    end
  end

  def delete_passenger_carriage(passenger_carriage)
    if speed == 0
      @passenger_train_carriages.delete(passenger_carriage) if @passenger_train_carriages.include?(passenger_carriage)
    end
  end
end
