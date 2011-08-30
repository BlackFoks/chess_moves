require 'spec_helper'

describe ChessMoves::PadCell do
  let(:pad) do
    ChessMoves::PhonePad.new do
      [[ 1,  2,  3 ],
       [ 4,  5,  6 ],
       [ 7,  8,  9 ],
       ['*', 0, '#']]
    end
  end
  
  subject { pad[2, 1] }
  
  it { should_not be_nil }
  its(:pos) { should == [2, 1] }
  its(:value) { should == 6 }
  its(:pad) { should_not be_nil }
end