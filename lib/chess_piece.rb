module ChessMoves
  class ChessPiece
    attr_accessor :type, :pad, :pos
    
    def initialize(type, options = {})
      @type = type
      @pad = options[:pad]
      # @pos = @pad.pos_of_value(options[:at])
    end
  end
end