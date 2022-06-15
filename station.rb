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

  def show_trains_type(type)
    @trains.each { |train| puts train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end
end

