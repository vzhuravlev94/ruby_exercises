class CargoCarriage
  attr_reader :type, :carriage

  def initialize
    @type = "cargo"
  end
end


=begin
class Train
  attr_accessor :number, :type, :speed, :route, :carriages_amount, :current_station

  def initialize(number)
    @number = number
    @speed = 0
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

  def current_station
    route.stations_list[@current_station_index]
  end

  def next_station
    route.stations_list[@current_station_index + 1]
  end

  def previous_station
    route.stations_list[@current_station_index - 1]
  end
end
=end
