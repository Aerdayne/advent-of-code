class Part1
  def solve
    stack_rows = Utils::Input
      .parse(with_index: false)
      .take_while { |row| !row.chomp.empty? }
      .reverse

    stack_count = stack_rows.first.split(' ').map(&:strip).last.to_i
    stacks = Array.new(stack_count) { [] }
    stacks_iterator = stacks.cycle

    stack_rows[1..].each do |row|
      row.chomp.chars.each_slice(4) do |(_, content, _, _)|
        stack = stacks_iterator.next
        stack << content unless content.strip.empty?
      end
    end

    Utils::Input
      .parse(with_index: false)
      .filter_map { |row| row.chomp.scan(/\d+/).map(&:to_i) if row.start_with?('move') }
      .each do |(count, from, to)|
        count.times { stacks[to - 1] << stacks[from - 1].pop }
      end

    stacks.map(&:last).join
  end
end

class Part2
  def solve
    stack_rows = Utils::Input
      .parse(with_index: false)
      .take_while { |row| !row.chomp.empty? }
      .reverse

    stack_count = stack_rows.first.split(' ').map(&:strip).last.to_i
    stacks = Array.new(stack_count) { [] }
    stacks_iterator = stacks.cycle

    stack_rows[1..].each do |row|
      row.chomp.chars.each_slice(4) do |(_, content, _, _)|
        stack = stacks_iterator.next
        stack << content unless content.strip.empty?
      end
    end

    Utils::Input
      .parse(with_index: false)
      .filter_map { |row| row.chomp.scan(/\d+/).map(&:to_i) if row.start_with?('move') }
      .each do |(count, from, to)|
        temp = []
        count.times { temp << stacks[from - 1].pop }
        temp.reverse.each { |content| stacks[to - 1] << content }
      end

    stacks.map(&:last).join
  end
end
