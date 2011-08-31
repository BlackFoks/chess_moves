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
      is_first = options[:is_first] || false
      
      if new == [0, 3] || new == [2, 3]
        return false
      end
      
      rule.call(now, new, is_first)
    end
  end
end