require "spec_helper"

describe ChessMoves::Rules do
  it { should_not be_nil }

  let(:rules) { ChessMoves::Rules }
  let(:rook_rule) { Proc.new { |now, new| (now[0] == new[0]) || (now[1] == new[1]) } }

  it "can add a rule" do
    rules.add :rook, rook_rule

    rules[:rook].should_not be_nil
    rules[:rook].call([1, 1], [1, 2]).should be_true
  end

  it "rook rule works" do
    rules.add :rook, rook_rule

    rules[:rook].call([1, 1], [1, 2]).should be_true
    rules[:rook].call([1, 1], [2, 1]).should be_true
    rules[:rook].call([1, 1], [0, 1]).should be_true
    rules[:rook].call([1, 1], [1, 1]).should be_true

    rules[:rook].call([1, 1], [0, 0]).should be_false
    rules[:rook].call([1, 1], [2, 2]).should be_false
    rules[:rook].call([1, 1], [2, 0]).should be_false
    rules[:rook].call([1, 1], [0, 2]).should be_false
  end

  it "validates moves" do
    rules.add :rook, rook_rule

    rules.valid_move?(:rook, :from => [2, 1], :to => [0, 1]).should be_true
    rules.valid_move?(:rook, :from => [2, 1], :to => [2, 3]).should be_false
    rules.valid_move?(:rook, :from => [2, 1], :to => [0, 2]).should be_false
  end

end