module ChessMoves
  class Rules
    @@rules = {}
    
    def self.add(name, proc)
      @@rules[name] = proc
    end
  
    def self.[](name)
      @@rules[name]
    end  
  end
end