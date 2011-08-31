@dsl_define = :rules

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
    if block_given?
      args.each do |type|
        @current_piece = type
        yield
      end
    else
      args.each do |type|
        @current_piece = type
        moves_like type
      end
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

class Array
  def %(other)
    [(self.x - other.x).abs, (self.y - other.y).abs]
  end
  
  def /(other)
    [(self.x - other.x), (self.y - other.y)]
  end
end