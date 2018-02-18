require 'byebug'

class SpiralMemory
  attr_reader :max_address
  attr_reader :memory_grid
  attr_reader :number_of_spirals

  def initialize(max_address)
    if !max_address.nil? && max_address >= 1
      max_address = Integer(max_address)

      @number_of_spirals = address_to_spiral(max_address)
      @max_address = max_address
      @origin = coordinate(0, 0)
      @memory_grid = {@origin => 1}
    end

    validate(max_address)
  end

  # Calculate the Manhattan distance (see https://en.wikipedia.org/wiki/Taxicab_geometry) from coordinate(x, y) to the
  # center of memory -- i.e., to the origin, coordinate(0, 0).
  def manhattan_distance_to_origin(x, y)
    source = coordinate(Integer(x), Integer(y))

    if @memory_grid[source].nil?
      raise(ArgumentError, "No such coordinate (#{x}, #{y}).")
    end

    @origin
        .each_cons(2)
        .map{|x1, y1| (x - x1).abs + (y - y1).abs}
        .first
  end

  def sum_all_neighbors(limit_address)
    limit_address = Integer(limit_address)
    validate(limit_address)

    x = 1
    y = 0

    x_direction = 1
    y_direction = 0

    (1..max_address).each {
      current_sum = 0

      (-1..1).each { |x_modifier|
        (-1..1).each { |y_modifier|
          adjacent = @memory_grid[[x + x_modifier, y + y_modifier]]
          current_sum += adjacent unless adjacent.nil?
        }
      }

      @memory_grid[[x, y]] = current_sum

      if @memory_grid[[x, y]] > max_address
        # manhattan_distance_to_origin(x, y)
      end

      new_x_direction = -(y_direction)
      new_y_direction = x_direction

      if @memory_grid[[x + new_x_direction, y + new_y_direction]].nil?
        x_direction = new_x_direction
        y_direction = new_y_direction
      end

      x = x + x_direction
      y = y + y_direction
    }

    # byebug
  end

  private

  def address_to_spiral(address)
    (Math.sqrt(address).ceil / 2).floor()
  end

  def validate(address)
    if address.nil?
      raise(ArgumentError, "Address cannot be nil.")
    elsif address > @max_address
      raise(ArgumentError, "Address #{address} is beyond maximum address #{@max_address}.")
    elsif address <= 0
      raise(ArgumentError, "Maximum address must be >= 1.")
    else
      nil
    end
  end

  def coordinate(x, y)
    [x, y]
  end

end