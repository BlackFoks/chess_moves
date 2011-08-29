class ChessPiece
  def initialize(type, options = {})
    @type = type
    @pad = options[:pad]
    @pos = @pad.pos_of_value(options[:at])
  end
  
  attr_reader :pos
  attr_reader :pad
  attr_reader :type
  
  def cell
    @pad[*@pos]
  end

  def can_move?(i, j)
    return false unless @pad
    if @type == :knight
      pos = [i.to_i, j.to_i]
      knight_cells = [[1,-2], [2,-1], [2, 1], [1, 2], [-1, 2],[-2, 1], [-2,-1], [-1,-2]]
      return knight_cells.include?(pos)
      # true
    end
  end
  
  def can_move
    cells = []
    @pad.cells.each do |c|
      i, j = [c.pos[0] - @pos[0], c.pos[1] - @pos[1]]
      cells << c if can_move?(i, j)
      # puts diff_pos.to_s
    end
    cells
    #@pad.cells.select{ |c| can_move?(c.pos[0] - @pos[0], c.pos[1] - @pos[1]) }
  end
  
  def move(i, j)
    cell = @pad[i, j]
    if can_move?(i, j) && cell
      @pos = [i, j]
    end
  end

end

class PhonePad
  def initialize
    @pad = {}
    yield.each_with_index do |row, j|
      row.each_with_index do |cell, i|
        @pad[[i,j]] = PadCell.new cell, :for => self 
      end
    end
  end

  def [](i, j)
    @pad[[i,j]]
  end
  
  def pos_of(cell)
    @pad.key(cell)
  end
  
  def pos_of_value(cell_value)
    pos_of(cells.select{ |c| c.value == cell_value }.first)
  end
  
  def cells
    @pad.values
  end
end

class PadCell
  def initialize(value, options = {})
    @value = value
    @pad = options[:for]
  end  
  [:pad, :value].each { |a| attr_reader a }
  def pos
    @pad.pos_of self
  end
  def to_s
    "#{@value}"
  end
end

class Node
  attr_accessor :parent
  
  def initialize(val)
    @val = val
    @children = []    
  end
  
  def <<(child)
    unless @children.include?(child)
      @children << child
      child.parent = self
    end
  end
  
  def each(&block)
    @children.each(block)
  end
  
  def path
    if @parent
      @parent.path + @val.to_s
    else
      @val.to_s
    end
  end  
end

class PathFinder
  def initialize(pad, chess_piece)
    @pad = pad
    @chess_piece = chess_piece
    @closed = []
    @root = Node.new chess_piece.cell.value
    @paths = []
    find(@chess_piece, @root)
  end
  
  def find(chess_piece, root)
    if root.path.length >= 3
      @paths << root.path
      return
    end
    
    # where can we go
    cells = chess_piece.can_move
    # where we now
    pos = chess_piece.pos
    cells.each do |cell|
      # new node
      node = Node.new cell.value
      root << node
      
      # if length == 10
      # if node.path.length == 3
      #   paths << node.path
      #   next
      # end
      
      # move to node
      new_cp = ChessPiece.new :knight, :pad => chess_piece.pad, :at => cell.value
      # @chess_piece.move(*cell.pos)
      # find...
      find(new_cp, node)
      # restore prev pos
      # @chess_piece.move(*pos)
    end
    
    @paths = paths
    
    #@root = Node.new chess_piece.cell.value
    #cells = chess_piece.can_move
  end
  
  def find_childs(chess_piece, root)
    cells = chess_piece.can_move
    cells.each do |cell|
      node = Node.new cell.value
      root << node
    end
  end
  
  attr_reader :paths
  
end

# real app

phone_pad = PhonePad.new do
  [
    [ 1,  2,  3 ],
    [ 4,  5,  6 ],
    [ 7,  8,  9 ],
    ['*', 0, '#']
  ]
end

# puts phone_pad.pos_of_value(1).to_s
# puts phone_pad.pos_of(phone_pad.cells.first).to_s

knight = ChessPiece.new :knight, :pad => phone_pad, :at => 7

pf = PathFinder.new phone_pad, knight

pf.paths.each do |p|
  puts p
end

# puts knight.pos.to_s
# puts knight.cell.pos.to_s

# puts knight.can_move?(-1,-2)
# puts knight.can_move?(-1,-1)
# puts knight.cell.pos.to_s
# 
# r = Node.new 7
# n11 = Node.new 2
# n12 = Node.new 6
# n13 = Node.new '#'
# r << n11
# r << n12
# r << n13
# n27 = Node.new 9
# n13 << n27
# 
# puts n27.path

# knight.can_move.each { |c| puts c }


#queen = ChessPiece.new :queen, :at => phone_pad
#
#queen.phones.each do |number|
#  puts number
#end