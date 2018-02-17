class SpiralMemory
  attr_reader :max_address
  attr_reader :number_of_rings

  def initialize(max_address)
    if max_address < 0
      raise(NoMemoryError, "Maximum address must be >= 1.")
    end

    @number_of_rings = address_to_ring_number(max_address)
    @max_address = max_address
    @read_port_address = 1
    @memory_grid = Array.new(number_of_rings) { Array.new(number_of_rings) }
  end

=begin
  def read(address)
    validate(address)

    # should get the coordinates of the desired address
    # calculate the shortest (i.e., Manhattan) distance between those coordinates and @read_port_address
    # step to the read port along that shortest path
  end

  def write(address, value)
    validate(address)
    value = Integer(value)

    # should navigate to the desired address according to the spiral pattern
    # modify the value at that address
  end
=end


  private
  def manhattan_distance_to_read_port(address)
    
  end

  def address_to_ring_number(address)
    (Math.sqrt(address).ceil / 2).floor()
  end

  def validate(address)
    if address > @max_address || address < 0
      raise(NoMemoryError, "Address #{address} is beyond maximum address #{@max_address}.")
    end
  end
end