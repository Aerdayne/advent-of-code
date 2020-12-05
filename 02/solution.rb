require_relative '../utils/input'
require 'pry'

class Solution
  class << self
    Policy = Struct.new(:amount, :letter, :string)

    def solve
      policies = Input.parse([]) do |result, row, index|
        amount, letter, string = row.split(' ')
        result << Policy.new(
          Range.new(*amount.split('-').map(&:to_i)),
          letter.chr,
          string
        )
      end

      first_policy = new.part_one(policies)
      second_policy = new.part_two(policies)

      puts "Part one: #{first_policy}"
      puts "Part two: #{second_policy}"
    end
  end

  def part_one(policies)
    policies.count { |policy| policy.amount.include? policy.string.count(policy.letter) }
  end

  def part_two(policies)
    policies.count do |policy|
      positions, letter, string = policy.to_a
      string.chars.values_at(*positions.to_a.values_at(0, -1).map { |v| v -= 1 })
        &.map { |char| char == letter }
        &.inject(&:^)
    end
  end
end

Solution.solve
