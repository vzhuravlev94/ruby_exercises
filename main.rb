require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Main

  @stations = []
  @routes = []
  @trains = []

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
      puts "Введите название станции"

      station_name = gets.chomp
      station = Station.new(station_name)

      @stations << station
      @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}

    when 2
      puts "Выберите тип поезда: 1 - создать поезд типа cargo, 2 - создать поезд типа passenger"

      input_train_type = gets.chomp.to_i

      if input_train_type == 1
        cargo_train = CargoTrain.new
        @trains << cargo_train

      elsif input_train_type == 2
        passenger_train = PassengerTrain.new
        @trains << passenger_train

      else
        puts "Ошибка! Поезд не создан"
      end

    when 3
      if @stations.length < 2
        puts "Для создания маршрута необходимо минимум 2 станции!"
      elsif
        @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}

        puts "Введите индекс первой станции (начиная с 0)"
        @first_station_index = gets.chomp.to_i
        first_station = @stations[@first_station_index]
        @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}

        puts "Введите индекс последней станции (начиная с 0)"
        @last_station_index = gets.chomp.to_i

        if @first_station_index == @last_station_index
          puts "Нельзя выбрать одну и ту же станцию!"
        else
          last_station = @stations[@last_station_index]
          route = Route.new(first_station, last_station)
          @routes << route
        end
      end

    when 4
      if @routes.length < 1
        puts "Создайте хотя бы 1 маршрут!"
      else
        puts "Выберите из существующих маршрутов"
        @routes.each_index {|index| puts "Маршрут #{index}: #{@routes[index].stations_list[0].station_name} - #{@routes[index].stations_list[-1].station_name}"}
        route_index = gets.chomp.to_i
        current_route = @routes[route_index]
        current_route_stations = current_route.stations_list

        puts "Список станций на маршруте:"
        current_route_stations.each_index {|index| puts "#{index}: #{(current_route_stations[index]).station_name}"}

        puts "Выберите действие: 1 - добавить станцию к выбранному маршруту, 2 - удалить станцию с выбранного маршрута"
        route_action_choice = gets.chomp.to_i
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
        else
          puts "Ошибка! Введите другое число!"
        end
      end

    when 5
      if @routes.length < 1
        puts "Создайте хотя бы 1 маршрут!"
      elsif @trains.length < 1
        puts "Создайте хотя бы 1 поезд!"
      else
        puts "Выберите поезд из общего списка по индексу"
        @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
        train_index = gets.chomp.to_i

        puts "Выберите маршрут из списка по индексу"
        @routes.each_index {|index| puts "Маршрут #{index}: #{@routes[index].stations_list[0].station_name} - #{@routes[index].stations_list[-1].station_name}"}
        route_index = gets.chomp.to_i

        @trains[train_index].set_route(@routes[route_index])
      end

    when 6
      if @trains.length < 1
        puts "Создайте хотя бы 1 поезд!"
      else
        puts "Выберите поезд из общего списка по индексу"
        @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
        train_index = gets.chomp.to_i
        if @trains[train_index].kind_of?CargoTrain
          cargo_carriage = CargoCarriage.new
          @trains[train_index].add_cargo_carriage(cargo_carriage)
        elsif @trains[train_index].kind_of?PassengerTrain
          passenger_carriage = PassengerCarriage.new
          @trains[train_index].add_passenger_carriage(passenger_carriage)
        else
          puts "Ошибка! Введите другое число!"
        end
      end

    when 7
      if @trains.length < 1
        puts "Создайте хотя бы 1 поезд!"
      else
        puts "Выберите поезд из общего списка по индексу"
        @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
        train_index = gets.chomp.to_i
        if @trains[train_index].kind_of?CargoTrain
          cargo_carriage = CargoCarriage.new
          @trains[train_index].delete_cargo_carriage(cargo_carriage)
        elsif @trains[train_index].kind_of?PassengerTrain
          passenger_carriage = CargoCarriage.new
          @trains[train_index].delete_cargo_carriage(passenger_carriage)
        else
          puts "Ошибка! Введите другое число!"
        end
      end

    when 8
      if @trains.length < 1
        puts "Создайте хотя бы 1 поезд!"
      else
        puts "Выберите поезд из общего списка по индексу"
        @trains.each_index {|index| puts "#{index}: #{@trains[index]}"}
        train_index = gets.chomp.to_i

        puts "Что нужно сделать: 1 - если поезд должен проехать вперёд, 2 - если должен проехать назад"
        moving_index = gets.chomp.to_i
        if moving_index == 1
          @trains[train_index].move_forward
        elsif moving_index == 2
          @trains[train_index].move_backward
        else
          puts "Ошибка! Введите другое число!"
        end
      end

    when 9
      puts "Что нужно сделать: 1 - показать список станций, 2 - показать список поездов на станции"
      show_index = gets.chomp.to_i
      if show_index == 1
        @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}
      elsif show_index == 2
        puts "Список станций на маршруте:"
        @stations.each_index {|index| puts "#{index}: #{(@stations[index]).station_name}"}

        puts "Выберите станцию из общего списка"
        station_index = gets.chomp.to_i
        @stations[station_index].trains.each  {|x| puts x}
      else
        puts "Ошибка! Введите другое число!"
      end

    when 0
      break

    else
      puts "Ошибка! Введите другое число!"
    end
  end
end
