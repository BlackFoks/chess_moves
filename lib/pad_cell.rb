module ChessMoves
  # Cell of a pad
  class PadCell
    attr_reader :pad, :value
    
    def initialize(value, options = {})
      @value = value
      @pad = options[:for]
    end  
    
    def pos
      @pad.pos_of self
    end
    
    def to_s
      "#{@value}"
    end
  end
end
