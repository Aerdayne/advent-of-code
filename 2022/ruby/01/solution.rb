class Part1
  def solve
    current_inventory = 0
    max = current_inventory
    Utils::Input.parse do |(row, _)|
      row = row.chomp
      current_inventory += row.to_i
      next unless row.empty?

      max = [max, current_inventory].max
      current_inventory = 0
    end

    max
  end
end

class Part2
  def solve
    current_inventory = 0
    inventories = Utils::Input.parse.with_object([]) do |(row, _), elfs|
      row = row.chomp
      current_inventory += row.to_i
      next unless row.empty?

      elfs << current_inventory
      current_inventory = 0
    end

    inventories.sort[-3..-1].inject(:+)
  end
end
