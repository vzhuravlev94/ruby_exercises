class Station
  attr_accessor :station_name, :trains

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def accept_train(train)
    @trains << train
  end

  def show_trains
    @trains.each {|train| puts train.number}
  end

  def show_trains_type
    @trains.each { |train| puts train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_accessor :stations_list

  def initialize(first_station = Station.new(station_name), last_station = Station.new(station_name))
    @stations_list = [first_station, @int_stations = [], last_station]
  end

  def first_station
    @stations_list.first
    # Station.new(station_name).accept_train(train)
  end

  def add_station(station)
    @int_stations << station
  end

  def delete_station(station)
    @int_stations.delete(station){"Станция на маршруте не найдена"}
  end

  def show_stations
    @stations_list.flatten.compact.each {|station| puts station}
  end
end

class Train
  attr_accessor :number, :type, :speed, :route, :carriages_amount, :current_station

  def initialize(number, type = %w[cargo passenger], carriages_amount) #тип поезда указывается по-другому, посомтреть скринкаст
    @number = number
    @type = type
    @carriages_amount = carriages_amount
    @speed = 0
  end

  def speed_increase(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage
    if speed == 0
      @carriages_amount += 1
    end
  end

  def delete_carriage
    if speed == 0 && @carriages_amount >= 1
      @carriages_amount -= 1
    end
  end

  def set_route(route)
    @route = route
    @current_station = 0
    route.first_station.accept_train(self)
  end

  def move_forward
    if next_station.accept_train(self)
      @current_station.send_train(self)
      next_station
    end
  end

  def move_backward
    if previous_station.accept_train(self)
      @current_station.send_train(self)
      previous_station
    end
  end

  def current_station
    route.stations_list[@current_station]
  end

  def next_station
    @next_station = @stations_list.flatten.compact[@current_station + 1]
  end

  def previous_station
    @previous_station = @stations_list.flatten.compact[@current_station - 1]
  end
end
