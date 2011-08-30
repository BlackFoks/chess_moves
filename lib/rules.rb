module ChessMoves
  class Rules
    @@rules = {}
    
    def self.add(name, proc)
      @@rules[name] = proc
    end
  
    def self.[](name)
      @@rules[name]
    end  
    
    def self.valid_move?(type, options={})
      rule = @@rules[type]
      now = options[:from]
      new = options[:to]
      rule.call(now, new)
    end
  end
end