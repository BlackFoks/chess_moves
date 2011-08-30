require 'spec_helper'

describe ChessMoves::ChessPiece do
  let(:knight) { ChessMoves::ChessPiece.new :knight }
  let(:queen) { ChessMoves::ChessPiece.new :queen, :pad => default_pad, :at => 4 }

  it "can be knight" do
    knight.should_not be_nil
  end

  it "have type" do
    knight.type == :knight
  end

  it "have pad" do
    queen.pad.should_not be_nil
  end

  it "have cell" do
    queen.cell.should_not be_nil
  end

  it "have appropriate cell" do
    queen.cell.value.should == 4
    queen.cell.pos.should == [0, 1]
  end
end