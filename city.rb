module TSP
  # City class
  class City
    attr_reader :name, :x_coordinate, :y_coordinate

    def initialize(name, x_coordinate, y_coordinate)
      @name = name
      @x_coordinate = x_coordinate
      @y_coordinate = y_coordinate
    end

    def distance_to(city)
      x_component = @x_coordinate - city.x_coordinate
      y_component = @y_coordinate - city.y_coordinate
      Math.sqrt(x_component**2 + y_component**2)
    end

    def inspect
      "@name = #{@name},
       @x_coordinate: #{@x_coordinate}, @y_coordinate: #{@y_coordinate}"
    end

    def to_s
      @name.to_s
    end

    def ==(other)
      @x_coordinate == other.x_coordinate && @y_coordinate == other.y_coordinate
    end
  end
end