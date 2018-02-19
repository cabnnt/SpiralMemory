require './spiral_memory.rb'

puts('This program calculates the Manhattan distance to the first sum in \'spiral memory\''\
     ' (defined here: https://gist.github.com/DavidIvy003/4ff8cd3eac07bcae2a2451dda28a0a54)'\
     ' larger than integer n (n >= 1).')

puts('Input a value for n:')

n = gets().to_i

puts(SpiralMemory.new(n).sum_all_neighbors())
