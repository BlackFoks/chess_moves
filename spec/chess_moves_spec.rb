require "spec_helper"

describe ChessMoves do
  let(:rules) { ChessMoves::Rules }

  it "have rules" do
    rules.should_not be_nil
  end
end