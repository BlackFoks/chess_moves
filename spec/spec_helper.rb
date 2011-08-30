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