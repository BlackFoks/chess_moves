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
        # type changing
        trans_to = ChessMoves::Transformations.transforms_to(@type, :pos => self.pos)
        @type = trans_to if trans_to
      end
    end

    def types
      trans2 = ChessMoves::Transformations[@type]
      if trans2
        trans2_to = trans2.first
        return [@type, trans2_to]
      end
      [@type]
    end

  end
end