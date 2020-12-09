require_relative '../utils/input'
require 'pry'

class Solution
  class << self
    def solve
      id = 0
      answers = Input.parse([]) do |result, row, index|
        (id += 1) && next if row == "\n"
        result[id] ||= []
        result[id] << row.strip.split('')
      end

      unique = new.part_one(answers)
      union = new.part_two(answers)

      puts "Part one: #{unique}"
      puts "Part two: #{union}"
    end
  end

  def part_one(groups)
    groups.inject(0) do |unique, group|
      unique += group.flatten.uniq.count
    end
  end

  def part_two(groups)
    groups.inject(0) do |common, group|
      common += group.inject(:&).uniq.count
    end
  end
end

Solution.solve
