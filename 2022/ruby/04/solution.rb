class Part1
  def solve
    Utils::Input
      .parse
      .filter_map do |row|
        tuples = row.chomp.split(',')
        first, second = tuples.map { |tuple| Range.new(*tuple.split('-').map(&:to_i)) }
        first.cover?(second) || second.cover?(first)
      end
      .count
  end
end

class Part2
  def solve
    Utils::Input
      .parse
      .filter_map do |row|
        tuples = row.chomp.split(',')
        first, second = tuples.map { |tuple| Range.new(*tuple.split('-').map(&:to_i)) }
        [first, second].permutation.inject(false) do |is_overlapping, (a, b)|
          is_overlapping || (a.include?(b.begin) || a.include?(b.end))
        end
      end
      .count
  end
end
