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

# create a piece
piece = ChessMoves::ChessPiece.new ARGV[0].to_sym, :pad => phone_pad, :at => ARGV[1].to_i

# remember start time
start_time = Time.now

# create a finder
finder = ChessMoves::PathFinder.new phone_pad, piece, :debug => true

# get phones
phones = finder.phones.sort

# puts info
puts "======================================"
phones.each { |ph| puts ph }
puts "======================================"
puts "#{phones.size} phones found in #{Time.now - start_time} seconds"
puts "======================================"
