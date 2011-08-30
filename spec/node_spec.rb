require 'spec_helper'

describe ChessMoves::Node do
  subject { ChessMoves::Node.new }
  it { should_not be_nil }
  its(:parent) { should be_nil }
  its(:children) { should_not be_nil }
  its(:children) { should be_empty }
  its(:path) { should be_empty }
  
  let(:node7) { ChessMoves::Node.new 7 }
  let(:node2) { ChessMoves::Node.new 2 }
  
  it "should be able to add children" do
    childs = [2, '*', 9, 0].map { |v| ChessMoves::Node.new v }
    childs.each { |c| node7 << c }
    
    node7.children.size.should == 4
    childs.each { |c| node7.children.include?(c).should be_true }
  end
  
  it "children should have a path" do
    childs = [2, '*', 9, 0].map { |v| ChessMoves::Node.new v }
    childs.each { |c| node2 << c }
    
    paths = node2.children.map { |c| c.path }

    ['22', '2*', '29', '20'].each do |path|
      paths.include?(path).should be_true
    end
  end
  
  it "should be able to iterate" do
    node2.each { |n| n.should_not be_true }
  end
end