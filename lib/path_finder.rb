module ChessMoves
  class PathFinder
    attr_reader :counter

    def initialize(pad)
      @pad = pad
    end

    def search(opts={}, &block)
      @chess_piece = ChessMoves::ChessPiece.new opts[:for], :pad => @pad, :at => opts[:at]
      @phone_length = opts[:length] || 10

      # TODO: also we should pass transforms and clear the cache
      fill_cache(@chess_piece.type)

      @counter = 0
      find(@chess_piece, @chess_piece.cell.value.to_s, &block)
    end

    def find(piece, parent_phone, &block)
      # remember current pos
      pos = @chess_piece.pos
      # get valid cells for current position
      valid_cells = @valid_next[piece.type][pos].map { |ps| @pad[*ps] }

      valid_cells.each do |cell|
        # get new phone
        new_phone = parent_phone + cell.value.to_s

        # if have nessesary length
        if new_phone.length >= @phone_length
          # puts new_phone
          yield new_phone if block_given?
          @counter += 1
          next
        end

        # move piece
        @chess_piece.move(*cell.pos)
        # find...
        find(@chess_piece, new_phone, &block)
        # restore piece pos
        @chess_piece.pos = pos
      end
    end

    private

      def fill_cache(*args)
        # main cache object
        @valid_next = {}
        args.each do |piece_type|
          # cache for type
          @valid_next[piece_type] = {}
          # create temp chess piece
          piece = ChessMoves::ChessPiece.new piece_type, :pad => @pad, :at => 1
          # process...
          @pad.cells.each do |cell|
            piece.pos = cell.pos # fake move
            # save valid move for cell and piece type
            @valid_next[piece_type][cell.pos] = piece.valid_moves.map { |c| c.pos }
          end
        end
      end

  end
end