require_relative 'manufacturer_company'

class PassengerCarriage
  attr_reader :type
  include Manufacturer

  def initialize
    @type = "passenger"
  end
end
