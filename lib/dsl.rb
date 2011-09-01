@dsl_define = :rules

def cant_move(*args)
  opts = args.last
  pad = opts[:on]
  args.map{ |v| pad.pos_of_value v }.each { |pos| ChessMoves::Rules.impassable << pos }
end

def transforms_to(type, &block)
  if @current_piece
    ChessMoves::Transformations.add @current_piece, type, block
  end
end

def moves_like(*args)
  if @current_piece
    ChessMoves::ChessPiece.moves_like[@current_piece] ||= []
    ChessMoves::ChessPiece.moves_like[@current_piece] << args
    ChessMoves::ChessPiece.moves_like[@current_piece].flatten!
  end
end

def define(*args, &block)
  if @dsl_define == :rules
    ChessMoves::Rules.add args.first, block
  elsif @dsl_define == :pieces
    args.each do |type|
      @current_piece = type
      block_given? ? yield : moves_like(type)
    end
  end
end

def rules(&block)
  @dsl_define = :rules
  yield
end

def pieces(&block)
  @dsl_define = :pieces
  yield
end