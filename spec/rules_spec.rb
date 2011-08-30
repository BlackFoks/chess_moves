require "spec_helper"

describe "Rules" do  
  let(:rules) { ChessMoves::Rules }
  
  it "can add a rule" do
    rook_rule = Proc.new do |current_pos, testing_pos|
      i, j = current_pos
      ti, tj = testing_pos
      (ti == i) ^ (tj == j)
    end
    
    rules.add :rook, rook_rule
    
    rules[:rook].should_not be_nil
    rules[:rook].call([1, 1], [1, 2]).should be_true
  end
  
end