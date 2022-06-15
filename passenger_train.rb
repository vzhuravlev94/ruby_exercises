class PassengerTrain < Train
  def initialize
    @type = "passenger"
    @passenger_train_carriages = []
  end

  def add_passenger_carriage(passenger_carriage)
    if speed == 0 && passenger_carriage.kind_of?(PassengerCarriage)
      @passenger_train_carriages << passenger_carriage
    end
  end

  def delete_passenger_carriage(passenger_carriage)
    if speed == 0 && @carriages_amount >= 1
      @passenger_train_carriages.delete(passenger_carriage) if @passenger_train_carriages.include?(passenger_carriage)
    end
  end
end
