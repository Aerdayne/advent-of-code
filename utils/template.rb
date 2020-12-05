require_relative '../utils/input'
require 'pry'

class Solution
  class << self
    def solve
      Input.parse([]) do |result, row, index|
      end

      new.part_one()
      new.part_two()

      puts "Part one: #{}"
      puts "Part two: #{}"
    end
  end

  def part_one()
  end

  def part_two()
  end
end

Solution.solve
