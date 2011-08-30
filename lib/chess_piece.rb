module ChessMoves
  class ChessPiece
    attr_accessor :type, :pad, :pos

    def initialize(type, options = {})
      @type = type
      @pad = options[:pad]
      @pos = @pad.pos_of_value(options[:at]) if @pad
    end

    # current cell
    def cell
      @pad[*@pos]
    end

    # can we move to this cell?
    def can_move?(i, j)
      ChessMoves::Rules.valid_move? @type, :from => @pos, :to => [i, j]
    end

    def valid_moves
      @pad.cells.select { |c| self.can_move?(*c.pos) }
    end

    def move(i, j)
      if self.can_move?(i, j) && @pad[i, j]
        @pos = [i, j]
        #TODO: add type changing for a pawn
      end
    end

  end
end