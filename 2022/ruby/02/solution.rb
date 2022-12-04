OUTCOMES = {
  'X' => { 'A' => 3, 'B' => 0, 'C' => 6 },
  'Y' => { 'A' => 6, 'B' => 3, 'C' => 0 },
  'Z' => { 'A' => 0, 'B' => 6, 'C' => 3 }
}

class Part1
  def solve
    Utils::Input.parse.inject(0) do |acc, (row)|
      opponent_move, player_move = row.chomp.split
      acc + OUTCOMES[player_move][opponent_move] + player_move.ord % 'W'.ord
    end
  end
end

MOVES = {
  'X' => { 'A' => 'Z', 'B' => 'X', 'C' => 'Y' },
  'Y' => { 'A' => 'X', 'B' => 'Y', 'C' => 'Z' },
  'Z' => { 'A' => 'Y', 'B' => 'Z', 'C' => 'X' }
}

class Part2
  def solve
    Utils::Input.parse.inject(0) do |acc, (row)|
      opponent_move, player_move = row.chomp.split
      required_move = MOVES[player_move][opponent_move]
      acc + OUTCOMES[required_move][opponent_move] + required_move.ord % 'W'.ord
    end
  end
end
