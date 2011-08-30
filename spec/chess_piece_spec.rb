require 'spec_helper'

describe ChessMoves::ChessPiece do
  it "can be knight" do
    knight = ChessMoves::ChessPiece.new :knight    
    knight.should_not be_nil
  end
  
  it "have type" do
    knight = ChessMoves::ChessPiece.new :knight
    knight.type == :knight
  end
  
  it "have pad" do
    queen = ChessMoves::ChessPiece.new :queen, :pad => "FakePad"
    queen.pad.should_not be_nil
  end
end