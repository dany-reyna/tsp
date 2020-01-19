module TSP
  # Generation class
  class Generation
    attr_reader :name, :list

    def initialize(name, list)
      @name = name
      @list = list
    end

    def breed(sort: true, mutate: true)
      Generation.new(@name + 1, List.new(nodes: @list.best_nodes,
                                         sort: sort, mutate: mutate))
    end

    def inspect
      "@name: #{@name}, @list: <#{@list}>"
    end

    def to_s
      string = ''
      @list.to_s.each_line { |s| string << "#{@name}\t\t\t#{s}" }
      string
    end
  end
end