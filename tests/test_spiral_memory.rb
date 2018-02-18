require "./src/spiral_memory.rb"
require "test/unit"

class TestSpiralMemory < Test::Unit::TestCase
  @example_grid = [[17, 16, 15, 14, 13],
                   [18, 5, 4, 3, 12],
                   [19, 6, 1, 2, 11],
                   [20, 7, 8, 9, 10],
                   [21, 22, 23, 24, 25]]

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
    spiral_memory_2048 = SpiralMemory.new(2048)

    assert_equal(0, spiral_memory_2048.manhattan_distance(1))
    assert_equal(3, spiral_memory_2048.manhattan_distance(12))
    assert_equal(2, spiral_memory_2048.manhattan_distance(23))
    assert_equal(31, spiral_memory_2048.manhattan_distance(1024))

    assert_raise (ArgumentError) {
      spiral_memory_2048.manhattan_distance(0)
    }
    assert_raise (ArgumentError) {
      spiral_memory_2048.manhattan_distance(-1)
    }
    assert_raise (ArgumentError) {
      spiral_memory_2048.manhattan_distance(nil)
    }
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