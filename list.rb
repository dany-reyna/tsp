module TSP
  # List class
  class List
    attr_reader :nodes

    def initialize(nodes: nil, cities: nil, list_size: 100,
                   sort: true, mutate: false)
      if nodes
        @nodes = populate_from_crossover(nodes, list_size)
      elsif cities
        @nodes = populate_from_cities(cities, list_size)
      end
      @nodes.sort_by!(&:distance) if sort
      @nodes.first.mutate(4, 9) if mutate
    end

    def populate_from_crossover(nodes, size)
      list = []
      4.times do |i|
        node_index = size * i / 4 + 1
        list << fill_quarter(nodes, size, i + 1, node_index)
      end
      list.flatten!
    end

    def fill_quarter(nodes, size, loop_index, node_index)
      list = []
      nodes.cycle(2).each_slice(loop_index * 2) do |array|
        loop_index.times do |i|
          list << array[i].crossover_with(array[i + loop_index], node_index)
          node_index += 1
          return list if list.size == size / 4
        end
      end
    end

    def populate_from_cities(cities, size)
      list = []
      size.times do |i|
        list << Node.new(i + 1, cities)
      end
      list
    end

    def best_nodes(number_of_nodes: 50)
      @nodes[0...number_of_nodes]
    end

    def inspect
      string = "@nodes: [\n"
      @nodes.each do |node|
        string << "#{node.inspect}\n"
      end
      string << ']'
    end

    def to_s
      string = ''
      @nodes.each do |node|
        string << "#{node}\n"
      end
      string
    end

    private :populate_from_crossover, :fill_quarter, :populate_from_cities
  end
end