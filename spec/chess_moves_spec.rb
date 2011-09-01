require "spec_helper"

describe ChessMoves do
  it "have rules" do
    ChessMoves::Rules.should_not be_nil
  end

  it "have transformations" do
    ChessMoves::Transformations.should_not be_nil
  end

  it "have chess piece" do
    ChessMoves::ChessPiece.should_not be_nil
  end

  it "have cell" do
    ChessMoves::PadCell.should_not be_nil
  end

  it "have pad" do
    ChessMoves::PhonePad.should_not be_nil
  end

  it "have finder" do
    ChessMoves::PathFinder.should_not be_nil
  end
end