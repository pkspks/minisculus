require File.expand_path("../helper/spec_helper", __FILE__)

describe MarkI do
  it "should shift alphabets by given count" do
    cipher = MarkI.new 6

    cipher.cipher('Strong NE Winds!').should == 'Yzxutm5TK5cotjy2'
    cipher.decipher('Yzxutm5TK5cotjy2').should == 'Strong NE Winds!'
  end
end

describe MarkII do
  it "should shift alphabets by given count" do
    cipher = MarkII.new(2, 5)

    cipher.cipher('abc').should == 'STU'
    cipher.decipher('STU').should == 'abc'
  end
end

describe MarkIV do
  it "should decode" do
    cipher = MarkIV.new(4, 7)

    MarkIV.new(2, 5).cipher('abc').should == 'SWZ'
    cipher.cipher('The white cliffs of Alghero are visible at night').should == "JMl0kBp?20QixoivSc.2\"vvmls8KOk\"0jA,4kgt0OmUb,pm."
    cipher.decipher("JMl0kBp?20QixoivSc.2\"vvmls8KOk\"0jA,4kgt0OmUb,pm.").should == 'The white cliffs of Alghero are visible at night'
  end
end