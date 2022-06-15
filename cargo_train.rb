class CargoTrain < Train
  def initialize
    @type = "cargo"
    @cargo_train_carriages = []
  end

  def add_cargo_carriage(cargo_carriage)
    if speed == 0 && cargo_carriage.kind_of?(CargoCarriage)
      @cargo_train_carriages << cargo_carriage
    end
  end

  def delete_cargo_carriage(cargo_carriage)
    if speed == 0 && @carriages_amount >= 1
      @cargo_train_carriages.delete(cargo_carriage) if @cargo_train_carriages.include?(cargo_carriage)
    end
  end
end
