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
