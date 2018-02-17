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

    assert_raise {
      SpiralMemory.new(-1)
    }

    spiral_memory_25 = SpiralMemory.new(valid_max_address)
    assert_equal(2, spiral_memory_25.number_of_rings)
  end

  private
  def print_grid(grid)
    grid.each { |row|
      row.each { |x|
        print((Math.sqrt(x).ceil / 2).floor, ", ")
      }
      puts
    }
  end
end