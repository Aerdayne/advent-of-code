class Part1
  def solve
    triples = Utils::Input.parse(with_index: false).each_slice(3)
    tuples = triples.map { |(first, second, _)| [eval(first), eval(second)] }

    compare = lambda { |first, second|
      case [first, second]
      in [Array, Array]
        [first.size, second.size].min.times do |id|
          value = compare[first[id], second[id]]
          return value unless value.zero?
        end
        return 1 if first.size > second.size
        return -1 if first.size < second.size

        0
      in [Integer, Array]
        compare[[first], second]
      in [Array, Integer]
        compare[first, [second]]
      in [Integer, Integer]
        first <=> second
      end
    }

    count = 0
    tuples.each_with_index do |tuple, index|
      first, second = tuple

      count += (index + 1) if compare[first, second] == -1
    end
    count
  end
end

class Trie
  class Node
    attr_reader :value, :count, :children, :order
    attr_accessor :is_terminal

    def initialize(value)
      @value = value
      @count = 0
      @is_terminal = false
      @children = {}
    end

    def increment_count
      @count += 1
    end

    def set_order(order)
      @order = order
    end

    def []=(char, child)
      @children[char] = child
    end

    def [](char)
      @children[char]
    end
  end

  attr_reader :root

  def initialize
    @root = Node.new('')
  end

  def insert(chars)
    node = root

    chars.each do |char|
      new_node = node[char.to_i] || Node.new(char.to_i)
      node[char.to_i] = new_node
      node = new_node
    end

    node.increment_count
    node.is_terminal = true

    nil
  end

  def mark_orders
    stack = [root]
    order = 1

    until stack.empty?
      node = stack.pop

      if node.is_terminal
        node.set_order(order)
        order += node.count
      end

      sorted_children = node.children.sort_by { |key, _value| -key }
      sorted_children.each do |(_, child)|
        stack << child
      end
    end
  end

  def extract_order(chars)
    node = root
    chars.each do |char|
      return false if node[char.to_i].nil?

      node = node[char.to_i]
    end

    node.is_terminal ? node.order : false
  end
end

class Part2
  def solve
    trie = Trie.new
    decoder_keys = ['[[2]]', '[[6]]'].map { |key| key.scan(/\d+/).map(&:to_i).map(&:succ) }

    Utils::Input
      .parse
      .each do |line|
        next if line.empty?

        chars = line.scan(/\d+|\[\]/).map { |digit| digit == '[]' ? '0' : (digit.to_i + 1).to_s }
        trie.insert(chars)
      end

    decoder_keys.each do |decoder_key|
      trie.insert(decoder_key)
    end

    trie.mark_orders

    decoder_keys.map { |decoder_key| trie.extract_order(decoder_key) }.inject(:*)
  end
end
