class SpiralMemory

  attr_reader :max_address
  attr_reader :memory_grid

  def initialize(max_address)
    if !max_address.nil? && max_address >= 1
      max_address = Integer(max_address)

      @max_address = max_address
      @origin = coordinate(0, 0)
      @memory_grid = { @origin => 1 }
    end

    validate(max_address)
  end

  # Calculate the Manhattan distance (see https://en.wikipedia.org/wiki/Taxicab_geometry) from coordinate(x, y) to the
  # origin, coordinate(0, 0) -- i.e., to the center of memory.
  def manhattan_distance_to_origin(x, y)
    source = coordinate(Integer(x), Integer(y))

    if @memory_grid[source].nil?
      raise(ArgumentError, "No such coordinate (#{x}, #{y}).")
    end

    [source, @origin].transpose
        .map{ |x1, x2| (x2 - x1).abs }
        .reduce(:+)
  end

  # Populate the memory grid by spiraling outward from (0, 0), counter-clockwise, and summing adjacent values
  # as they are generated. Return the Manhattan distance to the first such value that is greater than the input.
  def sum_all_neighbors(limit_address = nil)
    limit_address = limit_address || @max_address
    clear_memory()  # ensures grid is empty before calculations begin

    limit_address = Integer(limit_address)
    validate(limit_address)

    current = coordinate(1, 0)
    direction = coordinate(1, 0)

    translation = (-1..1).to_a
    translation = translation.product(translation)

    distances = []

    (1..@max_address).each {
      sum = 0

      translation.each { |t_x, t_y|
        adjacent = @memory_grid[coordinate(current.first() + t_x, current.last() + t_y)]
        sum += adjacent unless adjacent.nil?
      }

      @memory_grid[current] = sum

      if @memory_grid[current] > limit_address
        distances.append(manhattan_distance_to_origin(current.first(), current.last()))
      end

      look_direction = coordinate(-direction.last(), direction.first())  # new direction is now (-y, x)
      look = [look_direction, current].transpose.map{ |x| x.reduce(:+) }
      direction = look_direction if @memory_grid[look].nil?

      current = [current, direction].transpose.map{ |new| new.reduce(:+) }
    }

    distances.first()
  end

  private

  def clear_memory()
    @memory_grid = {@origin => 1}
  end

  def validate(address)
    if address.nil?
      raise(ArgumentError, "Address cannot be nil.")
    elsif address > @max_address
      raise(ArgumentError, "Address #{address} is beyond maximum address #{@max_address}.")
    elsif address <= 0
      raise(ArgumentError, "Maximum address must be >= 1.")
    end
  end

  def coordinate(x, y)
    [x, y]
  end

end