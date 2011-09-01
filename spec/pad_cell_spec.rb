require 'spec_helper'

describe ChessMoves::PadCell do
  let(:pad) { default_pad }
  subject { pad[2, 1] }

  it { should_not be_nil }
  its(:pos) { should == [2, 1] }
  its(:value) { should == 6 }
  its(:pad) { should_not be_nil }
  its(:pad) { should == pad}
end