module ChessMoves
  class ChessPiece
    attr_accessor :type, :pad, :pos, :first_move

    @@moves_like = {}
    def self.moves_like
      @@moves_like
    end

    def initialize(type, options = {})
      @type = type
      @pad = options[:pad]
      @pos = @pad.pos_of_value(options[:at]) if @pad
      @first_move = true
    end

    # current cell
    def cell
      @pad[*@pos]
    end

    def first_move?
      @first_move
    end

    # can we move to this cell?
    def can_move?(i, j)
      flag = false
      @@moves_like[type].each do |rule|
        flag |= ChessMoves::Rules.valid_move?(rule, :from => @pos, :to => [i, j], :is_first => self.first_move? )
      end
      flag
    end

    def valid_moves
      @pad.cells.select { |c| self.can_move?(*c.pos) }
    end

    def move(i, j)
      if self.can_move?(i, j) && @pad[i, j]
        @pos = [i, j]
        @first_move = false
        #TODO: add type changing for a pawn
      end
    end

  end
end