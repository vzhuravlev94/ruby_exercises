require_relative 'manufacturer_company'

class CargoCarriage
  attr_reader :type, :carriage, :number
  attr_accessor :volume, :occupied_volume
  include Manufacturer

  def initialize(volume, number = rand(0..999))
    @type = "cargo"
    @volume = volume.to_i
    @number = number
    @occupied_volume = 0
  end

  def take_volume(volume_value)
    if @volume > 0 && @volume >= volume_value && @occupied_volume <= @volume
      @occupied_volume += volume_value
      @volume -= volume_value
    end
  end

    def show_occupied_volume
      @occupied_volume
    end

    def show_empty_volume
      @volume
    end
end
