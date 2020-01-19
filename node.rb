module TSP
  # Node class
  class Node
    attr_reader :name, :tour, :distance

    def initialize(name, cities, shuffle: true)
      @name = name
      @tour = shuffle ? shuffle(cities) : cities
      @distance = 0
      @tour.each_cons(2) do |from_city, destination_city|
        @distance += from_city.distance_to(destination_city)
      end
    end

    def shuffle(cities)
      tour = cities.drop(1).shuffle
      tour.unshift(cities.first)
      tour << cities.first
    end

    def crossover_with(node, child_name)
      indexes = cycle_indexes(@tour, node.tour)
      child = child_tour(@tour, node.tour, indexes)
      Node.new(child_name, child, shuffle: false)
    end

    def cycle_indexes(first_parent, second_parent)
      indexes = [1]
      until first_parent[1] == second_parent[indexes.last] ||
            first_parent[-2] == first_parent[indexes.last]
        indexes << first_parent.index(second_parent[indexes.last])
      end
      indexes
    end

    def child_tour(first_p, second_p, indexes)
      child_tour = second_p.dup
      if first_p[indexes.first] != second_p[indexes.last]
        child_tour = correct_open_cycle(first_p, second_p, indexes, child_tour)
      elsif child_tour.include?(first_p[-2])
        child_tour = swap_for_second_to_last(first_p, second_p, child_tour)
      end
      indexes.each { |i| child_tour[i] = first_p[i] }
      child_tour
    end

    def correct_open_cycle(first_p, second_p, indexes, child_tour)
      child_tour[
        child_tour.index(first_p[indexes.first])
      ] = second_p[indexes.last]
      child_tour
    end

    def swap_for_second_to_last(first_p, second_p, child_tour)
      child_tour[child_tour.index(first_p[-2])] = second_p[-2]
      child_tour[-2] = first_p[-2]
      child_tour
    end

    def mutate(first_pos, second_pos)
      @tour[first_pos], @tour[second_pos] = @tour[second_pos], @tour[first_pos]
    end

    def inspect
      "@name: #{@name} @tour: #{@tour}, @distance: #{@distance}"
    end

    def to_s
      "#{@name}\t\t\t\t[#{@tour.join(",\t")}]\t#{@distance}"
    end

    private :shuffle, :cycle_indexes, :child_tour
    private :correct_open_cycle, :swap_for_second_to_last
  end
end
