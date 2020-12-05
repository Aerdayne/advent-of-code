# frozen_string_literal: true

require_relative '../utils/input'
require 'pry'

class Solution
  Seat = Struct.new(:id, :row)

  class << self
    def solve
      seats = Input.parse([]) do |result, data, _index|
        row = find((0..127).to_a, data[0..6].chars)
        col = find((0..7).to_a, data[7..9].chars)
        seat = Seat.new(row * 8 + col, row)
        result << seat
      end

      max_id = new.part_one(seats)
      my_seat = new.part_two(seats)

      puts "Part one: #{max_id}"
      puts "Part two: #{my_seat}"
    end

    def find(array, chars)
      chars.inject(0) do |_res, char|
        mid = array.first + ((array.last - array.first) / 2) + 1
        array = %w[F L].include?(char) ? (array.first..(mid - 1)) : (mid..array.last)
        array.first
      end
    end
  end

  def part_one(seats)
    seats.map(&:id).max
  end

  def part_two(seats)
    margins = seats.map(&:row).minmax
    filtered = seats.reject { |seat| margins.include? seat[:row] }
    sorted = filtered.map(&:id).sort
    ((sorted.first..sorted.last).to_a - sorted).first
  end
end

Solution.solve
