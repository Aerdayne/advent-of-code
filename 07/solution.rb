require_relative '../utils/input'
require 'pry'

class Bag
  attr_reader :name
  attr_accessor :bags

  class << self
    def repository=(repository)
      @repository = repository
    end

    def find_by_name(name)
      @repository.find { |bag| bag.name == name }
    end

    def select_containing(exact_bag)
      @repository.select { |bag| bag.bags.keys.include?(exact_bag) }
    end
  end

  def initialize(name, bags)
    @name = name
    @bags = bags
  end
end

class Solution
  class << self
    def solve
      result = Input.parse([]) do |result, row, index|
        current, associated = row.split('contain').map(&:strip).map(&:chop)
        association = if associated == 'no other bags'
                        {}
                      else
                        associated.split(', ').map { |bag| [(bag[-1] == 's' ? bag[2..-2] : bag[2..-1]), bag[0]] }.to_h
                      end
        object_map = association.map do |name, amount|
                       existing = result.find { |bag| bag.name == name }
                       if existing.nil?
                         bag = Bag.new(name, {})
                         result << bag
                         [bag, amount.to_i]
                       else
                         [existing, amount.to_i]
                       end
                     end.to_h

        existing = result.find { |bag| bag.name == current }
        if existing
          existing.bags = object_map
        else
          bag = Bag.new(current, object_map)
          result << bag
        end
      end

      Bag.repository = result

      containing = new.part_one
      capacity = new.part_two

      puts "Part one: #{containing}"
      puts "Part two: #{capacity}"
    end
  end

  def part_one
    possible_containers(Bag.find_by_name('shiny gold bag')) - 1
  end

  def part_two
    calculate_capacity(Bag.find_by_name('shiny gold bag'))
  end

  def possible_containers(bag)
    containing = Bag.select_containing(bag)
    containing.any? ? containing.inject(1) { |c, container| c += possible_containers(container) } : 0
  end

  def calculate_capacity(bag)
    return 0 if bag.bags.empty?
    
    bag.bags.inject(0) do |capacity, (bag, amount)|
      capacity += amount + amount * calculate_capacity(bag)
    end
  end
end

Solution.solve
