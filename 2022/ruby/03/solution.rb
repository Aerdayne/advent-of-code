class Part1
  def solve
    Utils::Input
      .parse
      .inject(0) do |sum, (row)|
        row = row.chomp
        left_compartment, right_compartment = row
          .chars
          .each_slice((row.size / 2.0).round)
          .map { |half| Set.new(half) }
        common_item = (left_compartment & right_compartment).first
        score =
          case common_item
          in 'a'..'z'
            common_item.ord - 'a'.ord + 1
          in 'A'..'Z'
            common_item.ord - 'A'.ord + 27
          end

        sum + score
      end
  end
end

class Part2
  def solve
    Utils::Input
      .parse
      .each_slice(3)
      .inject(0) do |sum, ((first), (second), (third))|
        common_item = (Set.new(first.chars) & Set.new(second.chars) & Set.new(third.chars)).first
        score =
          case common_item
          in 'a'..'z'
            common_item.ord - 'a'.ord + 1
          in 'A'..'Z'
            common_item.ord - 'A'.ord + 27
          end

        sum + score
      end
  end
end
