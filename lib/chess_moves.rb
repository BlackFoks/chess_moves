$: << File.dirname(__FILE__)

class Array
  def x
    self[0]
  end

  def y
    self[1]
  end
end

module ChessMoves

  PhoneLength = 10

  autoload :Rules, 'rules.rb'
  autoload :ChessPiece, 'chess_piece.rb'
  autoload :PadCell, 'pad_cell.rb'
  autoload :PhonePad, 'phone_pad.rb'
  # autoload :Node, 'node.rb'
  autoload :PathFinder, 'path_finder.rb'

  def self.pos_diff(start, target)
    [start.x - target.x, start.y - target.y]
  end
  
end

# load default rules

ChessMoves::Rules.add :rook, Proc.new { |curr, new| (now.x == new.x) || (now.y == new.y) }

ChessMoves::Rules.add :knight, Proc.new { |now, new|
  i, j = ChessMoves.pos_diff(now, new).map { |v| v.abs }
  (i == 0 && i == j) || (i == 1 || i == 2) && (j == 1 || j == 2) && (i != j)
}

ChessMoves::Rules.add :bishop, Proc.new { |now, new|
  i, j = ChessMoves.pos_diff(now, new)
  i.abs == j.abs
}
ChessMoves::Rules.add :king, Proc.new { |now, new|
  i, j = ChessMoves.pos_diff(now, new)
  [0, 1].include?(i.abs) && [0, 1].include?(j.abs)
}