$: << File.join(File.dirname(__FILE__), "/../lib")
require "chess_moves"

def default_pad
  ChessMoves::PhonePad.new do
    [[ 1,  2,  3 ],
     [ 4,  5,  6 ],
     [ 7,  8,  9 ],
     ['*', 0, '#']]
 end
end

def get_rook_rule_proc
  Proc.new { |now, new| (now[0] == new[0]) || (now[1] == new[1]) }
end

def get_knight_rule_proc
  Proc.new { |now, new| (now[0] == new[0]) || (now[1] == new[1]) }
end