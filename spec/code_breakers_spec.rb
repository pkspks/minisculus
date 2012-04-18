require_relative 'spec_helper'

describe MarkI do
  it "should shift alphabets by given count" do
    MarkI.new(6).cipher('abcdefghijklmnopqrstuvwxyz').should == 'ghijklmnopqrstuvwxyz.,?!\'"'
    MarkI.new(6).cipher('Strong NE Winds!').should == 'Yzxutm5TK5cotjy2'
  end
end