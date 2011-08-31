require 'spec_helper'

describe ChessMoves::PathFinder do
  before do
    @pad = default_pad
    @knight = ChessMoves::ChessPiece.new :knight, :pad => @pad, :at => 4
    @finder = ChessMoves::PathFinder.new @pad #, @knight
  end

  it "should find a phones for knight" do
    found = false
    @finder.search :for => :knight, :at => 4 do |phone|
      break if (found = phone == '4927618344')
    end
    
    found.should be_true
  end
end