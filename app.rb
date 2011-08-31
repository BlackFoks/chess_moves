#!/usr/bin/env ruby -wKU
require './lib/chess_moves'

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
finder.search :for => piece_type, :at => piece_pos, :length => max_length

# puts info
puts "======================================"
puts "#{finder.counter} phones found in #{Time.now - start_time} sec."
puts "======================================"
