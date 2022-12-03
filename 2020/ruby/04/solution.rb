require 'ostruct'

class Input
  class << self
    def parse(result, filename = 'input.txt', &block)
      raise ArgumentError unless block_given?

      file = File.expand_path(filename, __dir__)
      input = File.open(file).read

      input.each_line.with_index.with_object(result) do |(line, index), accum|
        block.call(accum, line, index)
      end
      result
    end
  end
end

class Solution
  FIELDS = {
    'byr' => ->(v) { (v =~ /^(19[2-9][0-9]|200[0-2])$/)&.zero? },
    'iyr' => ->(v) { (v =~ /^(201[0-9]|2020)$/)&.zero? },
    'eyr' => ->(v) { (v =~ /^(202[0-9]|2030)$/)&.zero? },
    'hgt' => ->(v) { !(v =~ /((?<=(^(15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-3])))cm$)|((?<=(^(59|6[0-9]|7[0-6])))in$)/).nil? },
    'hcl' => ->(v) { (v =~ /^\#([0-9]|[a-f]){6}$/)&.zero? },
    'ecl' => ->(v) { %w[amb blu brn gry grn hzl oth].include?(v) },
    'pid' => ->(v) { (v =~ /^\d{7}(?:\d{2})?$/)&.zero? }
  }.freeze

  class << self
    def solve
      id = 0
      result = Input.parse({}) do |hash, row, _index|
        (id += 1) && next if row == "\n"
        tokens = row.split(' ').map { |t| t.split(':') }.to_h
        hash[id] ||= {}
        hash[id].merge!(tokens)
      end
      passports = result.values.map { |passport| OpenStruct.new(passport) }

      first_batch = new.part_one(passports)
      second_batch = new.part_two(first_batch)

      puts "Part one: #{first_batch.size}"
      puts "Part two: #{second_batch}"
    end
  end

  def part_one(passports)
    passports.reject { |passport| FIELDS.keys.any? { |f| passport.dig(f).nil? } }
  end

  def part_two(passports)
    passports.inject(0) do |amount, passport|
      FIELDS.all? { |key, validation| validation.call(passport[key]) } ? amount += 1 : (next amount)
    end
  end
end

Solution.solve
