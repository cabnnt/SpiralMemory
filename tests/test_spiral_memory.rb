require "./src/spiral_memory.rb"
require "test/unit"

class TestSpiralMemory < Test::Unit::TestCase

  def test_initialization()
    assert_raise (ArgumentError) {
      SpiralMemory.new(0)
    }
    assert_raise (ArgumentError) {
      SpiralMemory.new(-1)
    }
    assert_raise (ArgumentError) {
      SpiralMemory.new(nil)
    }

    assert_nothing_raised { SpiralMemory.new(1) }
    assert_nothing_raised { SpiralMemory.new(4096) }
  end

  def test_manhattan_distance()
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
    spiral_memory_25 = SpiralMemory.new(25)
    spiral_memory_25.sum_all_neighbors(25)

    expected_sums.keys.each {|k|
      coordinate = spiral_memory_25.memory_grid.keys[k - 1]

      assert_equal(expected_sums[k], spiral_memory_25.memory_grid[coordinate])
    }

    spiral_memory_2048 = SpiralMemory.new(2048)

    first_larger_value_distances.each {|k, v|
      assert_equal(v, spiral_memory_2048.sum_all_neighbors(k))
    }
  end

  private

  def test_addresses
    [1, 12, 23, 32, 1024]
  end

  def coordinates
    { 1 => [0, 0], 12 => [2, 1], 23 => [0, -2], 32 => [2, 3], 1024 => [-15, 16] }
  end

  def distances
    { 1 => 0, 12 => 3, 23 => 2, 32 => 5, 1024 => 31 }
  end

  def expected_sums
    { 1 => 1, 12 => 57, 23 => 806, 26 => 957 }
  end

  def first_larger_value_distances
    { 1 => 2, 12 => 1, 59 => 3, 351 => 4, 747 => 2 }
  end

end