class Part1
  def solve
    current_inventory = 0
    max = current_inventory
    Utils::Input.parse do |(row)|
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
    Utils::Input
      .parse
      .with_object([]) do |(row), inventories|
        row = row.chomp
        current_inventory += row.to_i
        next unless row.empty?

        inventories << current_inventory
        current_inventory = 0
      end
      .sort[-3..]
      .inject(:+)
  end
end
