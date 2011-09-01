$: << File.dirname(__FILE__)

require 'array_helpers'
require 'dsl'

module ChessMoves

  autoload :Rules, 'rules.rb'
  autoload :Transformations, 'transformations.rb'
  autoload :ChessPiece, 'chess_piece.rb'
  autoload :PadCell, 'pad_cell.rb'
  autoload :PhonePad, 'phone_pad.rb'
  autoload :PathFinder, 'path_finder.rb'

end
