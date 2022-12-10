class Datagram
  def self.find_start_marker(start_message_size:)
    Utils::Input
      .parse(with_index: false)
      .first
      .each_char
      .with_index
      .with_object([]) do |(char, id), window|
        return id if window.uniq.count == start_message_size

        window.push(char)
        window.shift if window.count > start_message_size
      end
  end
end

class Part1
  def solve
    Datagram.find_start_marker(start_message_size: 4)
  end
end

class Part2
  def solve
    Datagram.find_start_marker(start_message_size: 14)
  end
end
