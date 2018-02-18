require "./src/spiral_memory.rb"
require "test/unit"

class TestSpiralMemory < Test::Unit::TestCase
  @example_grid_25 = [[17, 16, 15, 14, 13],
                      [18,  5,  4,  3, 12],
                      [19,  6,  1,  2, 11],
                      [20,  7,  8,  9, 10],
                      [21, 22, 23, 24, 25]]

  @example_sums_25 = [[147,  42,  33,  22,  59],
                      [304,   5,   4,   2,  57],
                      [330,  10,   1,   1,  54],
                      [351,  11,  23,  25,  26],
                      [362, 747, 806, 854, 905]]

  def test_initialization()
    valid_max_address = 25

    assert_raise (ArgumentError) {
      SpiralMemory.new(0)
    }
    assert_raise (ArgumentError) {
      SpiralMemory.new(-1)
    }
    assert_raise (ArgumentError) {
      SpiralMemory.new(nil)
    }

    spiral_memory_25 = SpiralMemory.new(valid_max_address)
    assert_equal(2, spiral_memory_25.number_of_spirals)
  end

  def test_manhattan_distance()
    test_addresses = [1, 12, 23, 32, 1024]
    coordinates = { 1 => [0, 0], 12 => [2, 1], 23 => [0, -2], 32 => [2, 3], 1024 => [-15, 16] }
    distances = { 1 => 0, 12 => 3, 23 => 2, 32 => 5, 1024 => 31 }

    spiral_memory_4096 = SpiralMemory.new(4096)
    spiral_memory_4096.sum_all_neighbors(4096)  # populates memory grid with coordinates

    test_addresses.each { |a|
      assert_equal(coordinates[a], spiral_memory_4096.memory_grid.keys[a - 1])
    }

    test_addresses.each { |a|
      coordinate = spiral_memory_4096.memory_grid.keys[a - 1]
      x = coordinate.first
      y = coordinate.last
      assert_equal(distances[a], spiral_memory_4096.manhattan_distance_to_origin(x, y))
    }

    assert_raise (ArgumentError) {
      spiral_memory_4096.manhattan_distance_to_origin(-999999, 999999)
    }
    assert_raise (TypeError) {
      spiral_memory_4096.manhattan_distance_to_origin(nil, 0)
    }
    assert_raise (TypeError) {
      spiral_memory_4096.manhattan_distance_to_origin(0, nil)
    }
  end

  def test_sum_all_neighbors()
    spiral_memory_25 = SpiralMemory.new(806)

    spiral_memory_25.sum_all_neighbors(806)

    # TODO: implement tests for sum_all_neighbors() -- array of summed values that should be calculated

  end

  private
  def print_grid(grid)
    grid.each { |row|
      row.each { |x|
        print(x, ", ")
      }
      puts
    }
  end
end