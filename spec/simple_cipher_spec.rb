require File.expand_path("../helper/spec_helper", __FILE__)

describe MarkI do
  it "should shift alphabets by given count" do
    cipher = MarkI.new 6

    cipher.decipher('Strong NE Winds!').should == 'Yzxutm5TK5cotjy2'
  end
end

describe MarkII do
  it "should shift alphabets by given count" do
    cipher = MarkII.new(2, 5)

    cipher.decipher('abc').should == 'STU'
  end
end