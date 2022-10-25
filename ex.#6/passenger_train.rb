class PassengerTrain < Train

  def initialize(number)
    super(number)
    @number = number
    @type = "passenger"
    @passenger_train_carriages = []
  end
end
