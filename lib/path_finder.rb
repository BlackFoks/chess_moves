module ChessMoves
  class PathFinder
    def initialize(pad, chess_piece, options={})
      # set objs
      @pad = pad
      @chess_piece = chess_piece

      # debug info
      @debug = options[:debug] || false
      @counter = 0

      # phones
      @node_phones = {}
      @node_phones_size = 0

      # prepare cache
      @valid_next = {}
      @valid_next[chess_piece.type] = {}
      pos = chess_piece.pos # save current pos
      @pad.cells.each do |cell|
        chess_piece.pos = cell.pos # fake move
        # save valid move for cell and piece type
        @valid_next[chess_piece.type][cell.pos] = chess_piece.valid_moves.map { |c| c.pos }
      end
      chess_piece.pos = pos # restore pos

      # find...
      find(@chess_piece, chess_piece.cell.value.to_s)
    end

    def phones
      @phones ||= @node_phones.keys.select { |k| k.length == ChessMoves::PhoneLength }
    end

    def find(piece, parent_phone)
      # count
      @counter += 1 if @debug

      # skip if processed
      return if @node_phones[parent_phone]

      # mark as processed
      @node_phones[parent_phone] = true
      @node_phones_size += 1

      # debug
      if @debug && @counter % 500 == 0
        @counter -= 500
        puts "#{@node_phones_size} ------ #{parent_phone}"
      end

      # if have nessesary length
      return if parent_phone.length >= ChessMoves::PhoneLength

      # remember current pos
      pos = @chess_piece.pos
      # get valid cells for current position
      valid_cells = @valid_next[piece.type][pos].map { |ps| @pad[*ps] }

      valid_cells.each do |cell|
        # get new phone
        new_phone = parent_phone + cell.value.to_s
        # check it
        next if @node_phones[new_phone]

        # move piece
        @chess_piece.move(*cell.pos)
        # find...
        find(@chess_piece, new_phone)
        # restore piece pos
        @chess_piece.pos = pos
      end
    end

  end
end