module ChessMoves
  class Rules
    @@rules = {}
    @@impassable = []

    def self.add(name, proc)
      @@rules[name] = proc
    end

    def self.[](name)
      @@rules[name]
    end

    def self.valid_move?(type, options={})
      rule = @@rules[type]
      start = options[:from]
      target = options[:to]
      is_first = options[:is_first] || false

      if @@impassable.include?(target)
        return false
      end

      rule.call(start, target, is_first)
    end

    def self.impassable
      @@impassable
    end
  end
end