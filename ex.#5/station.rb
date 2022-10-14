require_relative 'instance_counter'

class Station
  include InstanceCounter
  attr_accessor :station_name, :trains

  @@stations = []

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @@stations << self
    register_instance
  end

  def accept_train(train)
    @trains << train
  end

  def show_trains
    @trains.each {|train| puts train.number}
  end

  def show_trains_type(type)
    @trains.each { |train| puts train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end

  def self.all
    @@stations
  end
end

