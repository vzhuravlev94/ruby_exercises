require_relative 'manufacturer_company'

class CargoCarriage
  attr_reader :type, :carriage
  include Manufacturer

  def initialize
    @type = "cargo"
  end
end
