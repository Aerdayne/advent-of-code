OUTCOMES = {
  'X' => { 'A' => 3, 'B' => 0, 'C' => 6 },
  'Y' => { 'A' => 6, 'B' => 3, 'C' => 0 },
  'Z' => { 'A' => 0, 'B' => 6, 'C' => 3 }
}

class Part1
  def solve
    Utils::Input.parse.inject(0) { |acc, (row, _)| acc + OUTCOMES[row[2]][row[0]] + row[2].ord % 87 }
  end
end

MOVES = {
  'X' => { 'A' => 'Z', 'B' => 'X', 'C' => 'Y' },
  'Y' => { 'A' => 'X', 'B' => 'Y', 'C' => 'Z' },
  'Z' => { 'A' => 'Y', 'B' => 'Z', 'C' => 'X' }
}

class Part2
  def solve
    Utils::Input.parse.inject(0) do |acc, (row, _)|
      acc + OUTCOMES[MOVES[row[2]][row[0]]][row[0]] + MOVES[row[2]][row[0]].ord % 87
    end
  end
end
