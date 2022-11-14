require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_accessor :stations_list

  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
    register_instance
  end

  def first_station
    @stations_list.first
  end

  def add_station(station)
    @stations_list.insert(-2, station)
  end

  def delete_station(station)
    int_stations_list = @stations_list[1..-2]
    @stations_list.delete(station) if int_stations_list.include?(station)
  end

  def show_stations
    @stations_list.each {|station| puts station}
  end
end
