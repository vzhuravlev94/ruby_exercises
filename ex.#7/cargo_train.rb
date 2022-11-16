class CargoTrain < Train
  attr_reader :cargo_train_carriages

  def initialize(number)
    super(number)
    @number = number
    @type = "cargo"
  end
end
