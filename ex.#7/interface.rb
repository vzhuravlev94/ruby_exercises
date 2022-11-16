require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'manufacturer_company'
require_relative 'instance_counter'

class Interface
  attr_accessor :stations, :routes, :trains, :number, :passenger_carriage, :cargo_carriage

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  public

  def call
    loop do
      puts "-----------------------------------------------------------------------\nВас приветствует текстовое меню управления станцией!\nВыберите подходящий пункт:\n-----------------------------------------------------------------------"
      puts "Нажмите 1, чтобы создать станцию"
      puts "Нажмите 2, чтобы создать поезд"
      puts "Нажмите 3, чтобы создать маршрут"
      puts "Нажмите 4, чтобы управлять станциями в маршруте (добавлять, удалять)"
      puts "Нажмите 5, чтобы назначить маршрут поезду"
      puts "Нажмите 6, чтобы добавить вагоны к поезду"
      puts "Нажмите 7, чтобы отцепить вагоны от поезда"
      puts "Нажмите 8, чтобы перемещать поезд по маршруту вперед и назад"
      puts "Нажмите 9, чтобы просмотреть список станций и список поездов на станции"
      puts "Нажмите 0, чтобы выйти из программы\n-----------------------------------------------------------------------"

      choice = gets.chomp.to_i

      case choice

      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        manage_route
      when 5
        set_route
      when 6
        add_carriage
      when 7
        delete_carriage
      when 8
        move_train
      when 9
        show_lists
      when 0
        break
      else
        puts "Ошибка! Введите другое число!"
      end
    end
  end

  private

  def create_station
    puts "Введите название станции"
    station_name = gets.chomp
    station = Station.new(station_name)
    @stations << station
    @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}
  end

  def create_train
    begin
      puts "Выберите тип поезда: 1 - создать поезд типа cargo, 2 - создать поезд типа passenger"
      input_train_type = gets.to_i
      raise "Ошибка! Выберите один из двух типов" unless input_train_type == 1 || input_train_type == 2
      puts "Введите номер поезда в формате: ***-**, где * - цифры и буквы (можно без дефиса)"
      number = gets.chomp
        if input_train_type == 1
          cargo_train = CargoTrain.new(number)
          @trains << cargo_train
        elsif input_train_type == 2
          passenger_train = PassengerTrain.new(number)
          @trains << passenger_train
        end
      rescue Exception => a
        puts a.inspect
      retry
      end
  end

  def create_route
    begin
      raise "Для создания маршрута необходимо минимум 2 станции!" if @stations.length < 1
    rescue Exception => c
      puts c.inspect
    else
      begin
        puts "Введите индекс первой станции (начиная с 0)"
        @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}
        @first_station_index = gets.chomp.to_i
        first_station = @stations[@first_station_index]
        puts "Введите индекс последней станции (начиная с 0)"
        @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}
        @last_station_index = gets.chomp.to_i
        raise "Нельзя выбрать одну и ту же станцию!" if @first_station_index == @last_station_index
      rescue Exception => d
        puts d.message
      retry
      else
        last_station = @stations[@last_station_index]
        route = Route.new(first_station, last_station)
        @routes << route
      end
    end
  end

  def manage_route
    if @routes.length < 1
      puts "Создайте хотя бы 1 маршрут!"
      else
        puts "Выберите из существующих маршрутов"
        @routes.each_index {|index| puts "#{index}: #{@routes[index].stations_list[0].station_name} - #{@routes[index].stations_list[-1].station_name}"}
        route_index = gets.chomp.to_i
        current_route = @routes[route_index]
        current_route_stations = current_route.stations_list
        puts "Список станций на маршруте:"
        current_route_stations.each_index {|index| puts "#{index}: #{(current_route_stations[index]).station_name}"}
        puts "Выберите действие: 1 - добавить станцию к выбранному маршруту, 2 - удалить станцию с выбранного маршрута"
        route_action_choice = gets.chomp.to_i
        begin
        if route_action_choice == 1
          remaining_stations = @stations - current_route_stations
          puts "Список станций для добавления:"
          remaining_stations.each_index {|index| puts "#{index}: #{remaining_stations[index].station_name}"}
          station_add_index = gets.chomp.to_i
          current_route.add_station(remaining_stations[station_add_index])
        elsif route_action_choice == 2
          puts "Список станций на маршруте:"
          current_route_stations.each_index {|index| puts "#{index}: #{(current_route_stations[index]).station_name}"}
          station_delete_index = gets.chomp.to_i
          current_route.delete_station(current_route_stations[station_delete_index])
        end
        raise "Ошибка! Введите другое число!" unless route_action_choice == 1 || route_action_choice == 2
      rescue Exception => f
        puts f.message
      retry
      end
    end
  end

  def set_route
    begin
      raise "Создайте хотя бы 1 маршрут!" if @routes.length < 1
      raise "Создайте хотя бы 1 поезд!" if @trains.length < 1
    rescue Exception => g
      puts g.inspect
    else
      puts "Выберите поезд из общего списка по индексу:"
      @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
      train_index = gets.chomp.to_i
      puts "Выберите маршрут из списка по индексу:"
      @routes.each_index {|index| puts "#{index}: #{@routes[index].stations_list[0].station_name} - #{@routes[index].stations_list[-1].station_name}"}
      route_index = gets.chomp.to_i
      @trains[train_index].set_route(@routes[route_index])
    end
  end

  def add_carriage
    begin
      raise "Создайте хотя бы 1 поезд!" if @trains.length < 1
    rescue Exception => h
      puts h.inspect
    else
      puts "Выберите поезд из общего списка по индексу:"
      @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
      train_index = gets.chomp.to_i
      if @trains[train_index].kind_of?CargoTrain
        puts "Укажите объем грузового вагона:"
        volume = gets.chomp.to_i
        cargo_carriage = CargoCarriage.new(volume)
        @trains[train_index].add_carriage(cargo_carriage)
      elsif @trains[train_index].kind_of?PassengerTrain
        puts "Укажите количество мест в пассажирском вагоне:"
        seats = gets.chomp.to_i
        passenger_carriage = PassengerCarriage.new(seats)
        @trains[train_index].add_carriage(passenger_carriage)
      end
    end
  end

  def delete_carriage
    begin
      raise "Создайте хотя бы 1 поезд!" if @trains.length < 1
    rescue Exception => j
      puts j.inspect
    else
      puts "Выберите поезд из общего списка по индексу:"
      @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
      train_index = gets.chomp.to_i
      @trains[train_index].carriages.each_index { |index| puts "#{index}: #{@trains[train_index].carriages[index]}" }
      puts "Выберите вагон из списка по индексу"
      carriage_index = gets.chomp.to_i
      @trains[train_index].delete_carriage(@trains[train_index].carriages[carriage_index])
    end
  end

  def move_train
    begin
      raise "Создайте хотя бы 1 поезд!" if @trains.length < 1
    rescue Exception => l
      puts l.inspect
    else
      begin
        puts "Выберите поезд из общего списка по индексу:"
        @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
        train_index = gets.chomp.to_i
        puts "Что нужно сделать: 1 - если поезд должен проехать вперёд, 2 - если должен проехать назад"
        moving_index = gets.chomp.to_i
        if moving_index == 1
          @trains[train_index].move_forward
        elsif moving_index == 2
          @trains[train_index].move_backward
        end
        raise "Ошибка! Введите другое число!"
      rescue Exception => m
        puts m.inspect
      retry
      end
    end
  end

  def show_lists
    begin
      puts "Что нужно сделать: 1 - показать список станций, 2 - показать список поездов на станции, 3 - показать список вагонов у поезда, занять место или объем в вагоне"
      show_index = gets.chomp.to_i
      raise "Ошибка! Выберите один из двух типов" unless show_index == 1 || show_index == 2 || show_index == 3
        begin
        if show_index == 1
          puts "Список станций:"
          @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}
        elsif show_index == 2
          puts "Список станций на маршруте:"
          @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}
          station_index = gets.chomp.to_i
          @stations[station_index].station_block { |train|
            puts "Поезд: #{train.number}, тип: #{train.type}, количество вагонов: #{train.count_carriages}"
          }
        elsif show_index == 3
          @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
          train_index = gets.chomp.to_i
          if @trains[train_index].type == "passenger"
            @trains[train_index].train_block { |passenger_carriage|
              puts "номера вагонов: #{passenger_carriage.number}, тип #{passenger_carriage.type}, количество свободных мест: #{passenger_carriage.seats}, количество занятых мест: #{passenger_carriage.occupied_seats}"
            }
            puts "Выберите индекс нужного вагона, начиная с 0, в котором нужно занять место"
            carriage_index = gets.chomp.to_i
            passenger_carriage_choice = @trains[train_index].carriages[carriage_index - 1]
            passenger_carriage_choice.take_seat

          elsif @trains[train_index].type == "cargo"
            @trains[train_index].train_block { |cargo_carriage|
              puts "номер вагона: #{cargo_carriage.number}, тип #{cargo_carriage.type}, доступный свободный объем: #{cargo_carriage.show_empty_volume}, занятый объем: #{cargo_carriage.show_occupied_volume}"
            }
            puts "Выберите индекс нужного вагона, начиная с 0, в котором нужно занять объем"
            carriage_index = gets.chomp.to_i
            cargo_carriage_choice = @trains[train_index].carriages[carriage_index]
            puts "Введите величину объема, который нужно занять"
            volume_value = gets.chomp.to_i
            cargo_carriage_choice.take_volume(volume_value)
          end
        end
      rescue Exception => n
        puts n.inspect
        retry
      end
    rescue Exception => o
      puts o.inspect
    end
  end

end
