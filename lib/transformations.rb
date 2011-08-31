module ChessMoves
  class Transformations
    @@transformations = {}
    
    def self.add(from, to, proc)
      @@transformations[from] = [to, proc]
    end
  
    def self.[](from)
      @@transformations[from]
    end  
    
    def self.transforms_to(from, options={})      
      to, proc = @@transformations[from]
      pos = options[:pos]
      
      return nil unless proc
      return to if proc.call(pos)
      nil
    end
  end
end