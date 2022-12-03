require 'ostruct'

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
      forest = Input.parse([]) do |result, row, _index|
        result << row.strip.chars
      end
      
      first_slope = new.part_one(forest)
      second_slope = new.part_two(forest)
      
      puts "Part one: #{first_slope}"
      puts "Part two: #{second_slope}"
    end
  end
  
  def part_one(forest)
    slide(forest)
  end
  
  def part_two(forest)
    [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].inject(1) do |product, directions|
      product * slide(forest, directions)
    end
  end

  private

  def slide(forest, directions = [3, 1])
    direction = OpenStruct.new(x: directions[0], y: directions[1])
    position = OpenStruct.new(x: 0, y: 0)
    hits = 0
    loop do
      position.x += direction.x
      position.y += direction.y
      break if position.y >= forest.length - 1

      hits += 1 if forest[position.y][position.x % forest.first.size] == '#'
    end
    hits
  end
end

Solution.solve
