class Moves
  def self.parse
    Utils::Input
      .parse(with_index: false)
      .map do |row|
        directions, step = row.chomp.split
        directions =
          case directions.downcase.to_sym
          in :u
            [0, 1]
          in :l
            [-1, 0]
          in :d
            [0, -1]
          in :r
            [1, 0]
          end
        [directions, step.to_i]
      end
  end
end

class Rope
  def self.simulate(moves, knot_count:, traced_knot_id:)
    visited = Set.new
    knots = knot_count.times.with_object({}) { |knot_id, positions| positions[knot_id] = [0, 0] }

    moves.each do |(directions, step)|
      step.times do
        knots[0] = [knots[0][0] + directions[0], knots[0][1] + directions[1]]
        knots.to_a[1..].each do |knot_id, position|
          x_distance = knots[knot_id - 1][0] - position[0]
          y_distance = knots[knot_id - 1][1] - position[1]

          knots[knot_id] =
            case [x_distance, y_distance]
            in [-1, 0] | [-1, -1] | [-1, 1] | [1, 0] | [1, -1] | [1, 1] | [0, 0] | [0, -1] | [0, 1]
              position
            in [0, _]
              [position[0], y_distance.negative? ? position[1] - 1 : position[1] + 1]
            in [_, 0]
              [x_distance.negative? ? position[0] - 1 : position[0] + 1, position[1]]
            else
              [
                x_distance.negative? ? position[0] - 1 : position[0] + 1,
                y_distance.negative? ? position[1] - 1 : position[1] + 1
              ]
            end
        end
        visited << knots[traced_knot_id]
      end
    end

    visited.count
  end
end

class Part1
  def solve
    moves = Moves.parse
    Rope.simulate(moves, knot_count: 2, traced_knot_id: 1)
  end
end

class Part2
  def solve
    moves = Moves.parse
    Rope.simulate(moves, knot_count: 10, traced_knot_id: 9)
  end
end
