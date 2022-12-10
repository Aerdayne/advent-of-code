class Forest
  def self.parse(&block)
    @forest ||= Utils::Input.parse(with_index: false).map(&:chomp).each(&block)
  end

  def self.traverse(forest, &block)
    [forest, forest.transpose].each do |redirected_forest|
      redirected_forest.each do |treeline|
        [treeline, treeline.reverse].each(&block)
      end
    end
  end
end

class Part1
  def solve
    forest = Forest.parse.with_object([]) do |treeline, acc|
      acc << treeline.chars.map { |char| { height: char.to_i, is_visible: false } }
    end

    Forest.traverse(forest) do |redirected_treeline|
      max = -Float::INFINITY
      redirected_treeline.each do |tree|
        tree[:is_visible] = true if tree[:height] > max
        max = [max, tree[:height]].max
      end
    end

    is_visible = ->(tree) { tree[:is_visible] }
    forest.flatten.select(&is_visible).count
  end
end

class Part2
  def solve
    forest = Forest.parse.with_object([]) do |treeline, acc|
      acc << treeline.chars.map { |char| { height: char.to_i, scenic_scores: [] } }
    end

    Forest.traverse(forest) do |redirected_treeline|
      preceeding_trees = []
      redirected_treeline.each do |tree|
        blocker_position = preceeding_trees.index { |potential_blocker| potential_blocker >= tree[:height] }
        tree[:scenic_scores] << (blocker_position ? blocker_position + 1 : preceeding_trees.size)

        preceeding_trees = [tree[:height]] + preceeding_trees
      end
    end

    calculate_score = ->(tree) { tree[:scenic_scores].inject(:*) }
    forest.flatten.map(&calculate_score).max
  end
end
