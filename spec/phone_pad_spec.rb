require 'spec_helper'

describe ChessMoves::PhonePad do  
  subject { default_pad.clone }
  
  it { should_not be_nil }
  its(:cells) { should_not be_nil }
  its(:cells) { should_not be_empty }
  its(:width) { should == 3 }
  its(:height) { should == 4 }
  
  it "should have 12 cells" do
    subject.cells.length.should == 12
  end
  
  it "gets pos of a value" do
    subject.pos_of_value(1).should == [0, 0]
    subject.pos_of_value(2).should == [1, 0]
    subject.pos_of_value(3).should == [2, 0]
    subject.pos_of_value(4).should == [0, 1]
    subject.pos_of_value(5).should == [1, 1]
    subject.pos_of_value(6).should == [2, 1]
    subject.pos_of_value(7).should == [0, 2]
    subject.pos_of_value(8).should == [1, 2]
    subject.pos_of_value(9).should == [2, 2]
    subject.pos_of_value('*').should == [0, 3]
    subject.pos_of_value(0).should   == [1, 3]
    subject.pos_of_value('#').should == [2, 3]
  end
  
  it "get pos for cell" do
    cell = subject[2, 2]
    subject.pos_of(cell).should == [2, 2]
  end
  
  it "get cell by its pos" do
    subject[2, 2].value.should == 9
    subject[0, 0].value.should == 1
    subject[0, 3].value.should == '*'
  end
  
  it "get nil for cell that doesn't exists" do
    subject[4, 4].should be_nil
    subject[-1, -1].should be_nil
  end  
end