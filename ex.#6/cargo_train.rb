class CargoTrain < Train

  def initialize(number)
    super(number)
    @number = number
    @type = "cargo"
    @cargo_train_carriages = []
  end
end
