class Input
  class << self
    def parse(result, filename = 'input.txt', &block)
      raise ArgumentError unless block_given?

      file = File.expand_path(filename, __dir__)
      input = File.open(file).read

      input.each_line.with_index.with_object(result) do |(line, index), accum|
        block.call(accum, line, index)
      end
      result
    end
  end
end

class Solution
  class << self
    def solve
      cipher = Input.parse([]) do |result, row, index|
        result << row.to_i
      end

      first_invalid = new.part_one(cipher)
      sum_of_contiguous = new.part_two(cipher, first_invalid)

      puts "Part one: #{first_invalid}"
      puts "Part two: #{sum_of_contiguous}"
    end
  end

  def part_one(cipher)
    find_first_invalid(cipher)
  end

  def part_two(cipher, target)
    while cipher.shift do
      cipher.inject({ sum: 0, sequence: []}) do |hash, number|
        hash[:sum] += number
        hash[:sequence] << number
        break hash if hash[:sum] > target

        return hash[:sequence].minmax.inject(:+) if (hash[:sum] == target && !hash[:sequence].one?)

        hash
      end
    end
  end

  def find_first_invalid(payload)
    preamble, number = payload.first(25), payload[25]
    found = preamble.combination(2).to_a.find { |f, s| f + s == number }
    unless found.nil?
      find_first_invalid(payload[1..-1])
    else
      number
    end
  end
end

Solution.solve
