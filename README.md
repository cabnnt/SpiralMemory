# Calculating Manhattan Distances in Spiral Memory 

To run the program, `cd` to the root directory and run `ruby src/main.rb`.
You will be prompted to input a number, `n`, which will be used to initialize a new `SpiralMemory`
that 1.) sums all adjacent memory slots (as they are generated), and 2.) calculates
the [Manhattan distance](https://en.wikipedia.org/wiki/Taxicab_geometry) to
the first sum larger than the input. The printed output is this Manhattan distance.

To run tests, `cd` to the root directory and run `ruby tests/test_spiral_memory.rb`.

Written in `Ruby 2.5.0`.