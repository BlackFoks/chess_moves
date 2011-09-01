module ChessMoves
  # Represents chess piece on a board
  class ChessPiece
    @@moves_like = {}
    attr_accessor :type, :pad, :pos, :first_move

    def initialize(type, options = {})
      @type = type
      @pad = options[:pad]
      @pos = @pad.pos_of_value(options[:at]) if @pad
      @first_move = true
    end

    # Gets current cell
    def cell
      @pad[*@pos]
    end

    def first_move?
      @first_move
    end

    # Can we move to this cell?
    def can_move?(i, j)
      flag = false
      @@moves_like[type].each do |rule|
        flag |= ChessMoves::Rules.valid_move?(rule, :from => @pos, :to => [i, j],
            :is_first => self.first_move?)
      end
      flag
    end

    # Gets all valid moves from current pos
    def valid_moves
      @pad.cells.select { |c| self.can_move?(*c.pos) }
    end

    # Moves the piece
    def move(i, j)
      if self.can_move?(i, j) && @pad[i, j]
        # change pos
        @pos = [i, j]
        @first_move = false

        # change type
        trans_to = ChessMoves::Transformations.transforms_to(@type, :pos => self.pos)
        @type = trans_to if trans_to
      end
    end

    # Which types are used by the piece
    def types
      trans = ChessMoves::Transformations[@type]
      trans ? [@type, trans.first] : [@type]
    end

    def self.moves_like
      @@moves_like
    end

  end
end