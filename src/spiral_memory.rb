class SpiralMemory

  attr_reader :max_address
  attr_reader :number_of_spirals

  def initialize(max_address)
    if !max_address.nil? && max_address >= 1
      max_address = Integer(max_address)

      @number_of_spirals = address_to_spiral(max_address)
      @max_address = max_address
      @read_port_address = 1
    end

    validate(max_address)
  end

  # Calculate the Manhattan distance (see https://en.wikipedia.org/wiki/Taxicab_geometry) from `address` to the center
  # of memory.
  #
  # Specifically, calculate the distance from `address` to the nearest radial (where distance to center == `spiral`)
  # and then sum this with that radial's distance to the center.
  def manhattan_distance(address)
    validate(address)

    if address == 1
      0
    else
      radius = address_to_spiral(address)
      distance_between_corners = 2 * radius

      inner_spiral_side_length = 2 * radius - 1
      inner_spiral_area = (inner_spiral_side_length) ** 2
      inner_spiral_perimeter = 4 * inner_spiral_side_length + 4   # the number of elements in a spiral

      distance_from_maximum_element = address - (inner_spiral_area % inner_spiral_perimeter)
      distance_from_last_corner = distance_from_maximum_element % distance_between_corners

      distance_to_side_center = (distance_from_last_corner - radius).abs

      distance_to_side_center + radius
    end
  end

  private

  def address_to_spiral(address)
    (Math.sqrt(address).ceil / 2).floor()
  end

  def validate(address)
    if address.nil?
      raise(ArgumentError, "Address cannot be nil.")
    elsif address > @max_address # not initialized
      raise(ArgumentError, "Address #{address} is beyond maximum address #{@max_address}.")
    elsif address <= 0
      raise(ArgumentError, "Maximum address must be >= 1.")
    else
      nil
    end
  end

end