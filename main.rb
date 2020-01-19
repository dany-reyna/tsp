# Main file
module TSP
  require 'csv'
  require_relative 'city.rb'
  require_relative 'node.rb'
  require_relative 'list.rb'
  require_relative 'generation.rb'

  def self.read_cities_csv(file: 'cities.csv')
    cities = []
    csv_options = {
      encoding: 'UTF-8', headers: :first_row,
      header_converters: :symbol, converters: :all
    }

    CSV.foreach(file, csv_options) do |row|
      cities << City.new(row.to_hash[:city],
                         row.to_hash[:x_coordinate], row.to_hash[:y_coordinate])
    end
    cities
  end

  if $PROGRAM_NAME == __FILE__
    CX_GENERATIONS = 100
    HEADER = "Generación\tCromosoma\t\tContenido\
    \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\
    Recorrido\n".freeze

    generation = Generation.new(0, List.new(cities: read_cities_csv))
    output = ''
    output << HEADER
    output << generation.to_s

    CX_GENERATIONS.times do
      generation = generation.breed
      output << generation.to_s
    end

    File.open('output.txt', 'w') do |f|
      f.puts output
    end
  end
end
