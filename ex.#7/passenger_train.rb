class PassengerTrain < Train
  attr_reader :passenger_train_carriages

  def initialize(number)
    super(number)
    @number = number
    @type = "passenger"
    @passenger_train_carriages = []
  end
end
