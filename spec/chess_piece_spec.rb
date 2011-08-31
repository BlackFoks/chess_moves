require 'spec_helper'

describe ChessMoves::ChessPiece do
  let(:knight) { ChessMoves::ChessPiece.new :knight }
  let(:queen) { ChessMoves::ChessPiece.new :queen, :pad => default_pad, :at => 4 }
  let(:rook) { ChessMoves::ChessPiece.new :rook, :pad => default_pad, :at => 7 }

  before do
    rules { define :rook, &get_rook_rule_proc }
    pieces { define :rook }
  end

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

  it "should validate move" do
    rook.can_move?(0, 0).should be_true
    rook.can_move?(2, 2).should be_true
    rook.can_move?(2, 0).should be_false
    rook.can_move?(2, 3).should be_false
  end

  it "should provide valid moves" do
    valid_moves = rook.valid_moves
    valid_values = valid_moves.map { |cell| cell.value }

    [1, 4, 7, 8, 9].each do |v|
      valid_values.include?(v).should be_true
    end

    valid_values.length.should == 5
  end

  it "can move" do
    white_rook = ChessMoves::ChessPiece.new :rook, :pad => default_pad, :at => 8

    white_rook.move(0, 2)
    white_rook.pos.should == [0, 2]
    white_rook.move(0, 0)
    white_rook.pos.should == [0, 0]
    white_rook.move(2, 0)
    white_rook.pos.should == [2, 0]

    valid_values = white_rook.valid_moves.map { |cell| cell.value }
    valid_values.length.should == 5
    [1, 2, 3, 6, 9].each do |v|
      valid_values.include?(v).should be_true
    end
  end
end