#!/usr/bin/env ruby -wKU
require './lib/chess_moves'

rules do
  define :rook do |start, target|
    start.x == target.x || start.y == target.y
  end
  
  define :knight do |start, target|
    i, j = start % target # abs diff
    (i == 0 && j == 0) || (i == 1 && j == 2) || (i == 2 && j == 1)
  end
  
  define :bishop do |start, target|
    i, j = start % target
    i == j
  end
  
  define :king do |start, target|
    i, j = start % target
    [0, 1].include?(i) && [0, 1].include?(j)
  end
  
  define :pawn do |start, target|
    i, j = start / target # no abs diff
    (i == 0 && j == 0) || (i == 0) && (j == 1)
  end
end

pieces do  
  define :rook, :knight, :bishop, :king
  
  define :queen do
    moves_like :rook, :bishop, :king
  end
  
  define :pawn do
    moves_like :pawn
    # first_step_like :fast_pawn { |pos, h| pos.y >= h-2 }
    # transforms_to :queen { |pos| pos.y == 0 } 
  end
end

# exit

# create a pad
phone_pad = ChessMoves::PhonePad.new do
  [
    [ 1,  2,  3 ],
    [ 4,  5,  6 ],
    [ 7,  8,  9 ],
    ['*', 0, '#']
  ]
end

# remember start time
start_time = Time.now

# create a finder
finder = ChessMoves::PathFinder.new phone_pad #, piece, :debug => true

# get args
piece_type = ARGV[0].to_sym
piece_pos = ARGV[1].to_i
max_length = (ARGV[2] || 10).to_i

# search
finder.search :for => piece_type, :at => piece_pos, :length => max_length do |phone|
  puts phone
end

# puts info
puts "======================================"
puts "#{finder.counter} phones found in #{Time.now - start_time} sec."
puts "======================================"
