class Part1
  def solve
    Utils::Input.parse.inject(0) do |sum, (row, _)|
      row = row.chomp
      left_set, right_set = row.chars.each_slice((row.size / 2.0).round).map { |half| Set.new(half) }
      common = (left_set & right_set).first
      score = (common.ord % 96)
      score -= 38 if common.ord in 65..90

      sum + score
    end
  end
end

class Part2
  def solve
    Utils::Input.parse.each_slice(3).inject(0) do |sum, ((first, _), (second, _), (third, _))|
      common = (Set.new(first.chars) & Set.new(second.chars) & Set.new(third.chars)).first
      score = (common.ord % 96)
      score -= 38 if common.ord in 65..90

      sum + score
    end
  end
end
