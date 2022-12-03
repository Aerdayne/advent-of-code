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
      result = Input.parse([]) do |result, row, index|
        tokens = row.split(' ').map(&:strip)
        result << [tokens[0], tokens[1].to_i]
      end

      first_iteration = new.part_one(result)
      complete_execution = new.part_two(result)

      puts "Part one: #{first_iteration}"
      puts "Part two: #{complete_execution}"
    end
  end

  def part_one(program)
    calculate_pessimistically(program)
  end

  def part_two(program)
    program.each_with_index.inject([]) do |result, ((operation, value), index)|
      (next result) if operation == 'acc'

      mutated_program = program.map(&:clone)
      switched_operation = operation == 'jmp' ? 'nop' : 'jmp'
      mutated_program[index] = [switched_operation, value]
      result = calculate_accumulator(mutated_program)
      return result unless result.nil?
    end
  end

  def calculate_pessimistically(program)
    accumulator = 0
    visited = []
    index = 0
    while !(visited.include?(index))
      operation, value = program[index]
      visited << index
      case operation
      when 'jmp'
        index = index + value
      when 'acc'
        accumulator += value
        index += 1
      when 'nop'
        index += 1
      end
    end

    accumulator
  end

  def calculate_accumulator(program)
    acc = 0
    visited = {}
    index = 0
    while (visited[index].nil? || visited[index] <= 1)
      operation, value = program[index]
      break if index < 0

      return acc if index == program.size

      visited[index] ||= 0
      visited[index] += 1
      case operation
      when 'jmp'
        index = index + value
      when 'acc'
        acc += value
        index += 1
      when 'nop'
        index += 1
      end
    end

    nil
  end
end

Solution.solve
