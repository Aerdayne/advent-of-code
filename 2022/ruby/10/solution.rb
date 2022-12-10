class CPU
  attr_reader :x

  def initialize
    @x = 1
    @cycle = 0
  end

  def addx(value)
    2.times { yield(@cycle += 1) }

    @x += value
  end

  def noop = yield(@cycle += 1)
end

class Program
  def self.execute(cpu, &block)
    Utils::Input.parse(with_index: false) do |instruction|
      case instruction.split
      in ['addx', value]
        cpu.addx(value.to_i, &block)
      in ['noop']
        cpu.noop(&block)
      end
    end
  end
end

class Part1
  def solve
    cpu = CPU.new
    snapshots = {}
    Program.execute(cpu) do |cycle|
      snapshots[cycle] = cpu.x * cycle if (cycle % 20).zero? && (cycle % 40).nonzero?
    end

    snapshots.values.sum
  end
end

class Part2
  def solve
    cpu = CPU.new
    crt = Array.new(6) { Array.new(40) { '.' } }

    Program.execute(cpu) do |cycle|
      row_position = (cycle % 40) - 1
      column_position = cycle / 40
      crt[column_position][row_position] = '#' if (cpu.x - 1..cpu.x + 1).include?(row_position)
    end

    crt
  end
end
