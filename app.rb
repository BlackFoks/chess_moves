class ChessPiece
  def initialize(type, options = {})
    @type = type
    @pad = options[:pad]
    @pos = @pad.pos_of_value(options[:at])
  end
  
  attr_reader :pos
  attr_reader :pad
  attr_reader :type
  
  # current cell
  def cell
    @pad[*@pos]
  end

  # can we move to this cell?
  def can_move?(i, j)
    return false unless @pad
    if @type == :knight
      pos = [i.to_i, j.to_i]
      knight_cells = [[1,-2], [2,-1], [2, 1], [1, 2], [-1, 2],[-2, 1], [-2,-1], [-1,-2]]
      return knight_cells.include?(pos)
      # true
    end
  end
  
  # gets all cells in which we can move
  def can_move
    cells = []
    @pad.cells.each do |c|
      i, j = [c.pos[0] - @pos[0], c.pos[1] - @pos[1]] # get relative pos
      cells << c if can_move?(i, j)
      # puts diff_pos.to_s
    end
    cells
    #@pad.cells.select{ |c| can_move?(c.pos[0] - @pos[0], c.pos[1] - @pos[1]) }
  end
  
  # moves into given cell
  def move(i, j)
    cell = @pad[i, j]
    if can_move?(i, j) && cell
      @pos = [i, j]
    end
  end

end

# A "map"
class PhonePad
  def initialize
    @pad = {}
    # parse block
    yield.each_with_index do |row, j|
      row.each_with_index do |cell, i|
        @pad[[i,j]] = PadCell.new cell, :for => self 
      end
    end
  end

  # gets a cell
  def [](i, j)
    @pad[[i,j]]
  end
  
  # gets pos of a cell
  def pos_of(cell)
    @pad.key(cell)
  end
  
  # gets pos of a cell with specified value
  def pos_of_value(cell_value)
    pos_of(cells.select{ |c| c.value == cell_value }.first)
  end
  
  # gets all cells
  def cells
    @pad.values
  end
end

# Cell pa a map
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

# Node in a graph
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
  
  # gets path (aka "phone number")
  def path
    if @parent
      @parent.path + @val.to_s
    else
      @val.to_s
    end
  end  
end

# Finds desired path
class PathFinder
  def initialize(pad, chess_piece)
    @pad = pad
    @chess_piece = chess_piece
    @closed = []
    @root = Node.new chess_piece.cell.value
    @paths = []
    find(@chess_piece, @root)
  end
  
  # finds a paths
  def find(chess_piece, root)
    if root.path.gsub(/[^\d]/, '').length >= 10
      @paths << root.path.gsub(/[^\d]/, '')
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
  
  # def find_childs(chess_piece, root)
  #   cells = chess_piece.can_move
  #   cells.each do |cell|
  #     node = Node.new cell.value
  #     root << node
  #   end
  # end
  
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

knight = ChessPiece.new :knight, :pad => phone_pad, :at => 9

pf = PathFinder.new phone_pad, knight

uniq_paths = pf.paths.uniq.sort
uniq_paths.each do |p|
  puts p
end

puts "Total: #{pf.paths.count}"
puts "Uniq: #{uniq_paths.count}"

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

puts "===================== Testing ==========="
puts true if uniq_paths.include?("9572943816")


#queen = ChessPiece.new :queen, :at => phone_pad
#
#queen.phones.each do |number|
#  puts number
#end