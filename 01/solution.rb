require_relative '../utils/input'
require 'pry'

class Solution
  class << self
    def solve
      numbers = Input.parse([]) do |result, row, _index|
        result << row.to_i
      end

      first_product = new.part_one(numbers)
      second_product = new.part_two(numbers)

      puts "Part one: #{first_product}"
      puts "Part two: #{second_product}"
    end
  end

  def part_one(numbers)
    find_product(numbers, 1)
  end

  def part_two(numbers)
    find_product(numbers, 2)
  end

  private

  def find_product(numbers, times)
    numbers.sort!
    result = []
    numbers.product(*([numbers] * times)) do |nums|
      (result = nums) && break if nums.inject(:+) == 2020
    end
    result.inject(:*)
  end
end

Solution.solve
