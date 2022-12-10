class Filesystem
  def self.du
    Utils::Input
      .parse(with_index: false)
      .each_with_object([])
      .with_object(Hash.new(0)) do |(line, stack), directory_map|
        case line.split
        in '$', 'cd', '..'
          stack.pop
        in '$', 'cd', dir
          stack << dir
        in /^\d+/ => size, _
          stack.inject([]) do |path, directory|
            path = [*path, directory].join('/')
            directory_map[path] += size.to_i
            path
          end
        else
        end
      end
  end
end

class Part1
  def solve
    directory_map = Filesystem.du
    lt_hundred_thousand = -> size { size < 100_000 }
    directory_map.values.select(&lt_hundred_thousand).inject(&:+)
  end
end

class Part2
  def solve
    directory_map = Filesystem.du
    has_freeable_space = -> size { size > directory_map['/'] - 40_000_000 }
    directory_map.values.select(&has_freeable_space).min
  end
end
