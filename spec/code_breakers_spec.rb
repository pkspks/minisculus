require File.expand_path("../helper/spec_helper", __FILE__)

describe MarkI do
  it "should shift alphabets by given count" do
    code_breaker = MarkI.new 6

    code_breaker.cipher('abcdefghijklmnopqrstuvwxyz').should == 'ghijklmnopqrstuvwxyz.,?!\'"'
    code_breaker.cipher('Strong NE Winds!').should == 'Yzxutm5TK5cotjy2'
    code_breaker.decipher('Yzxutm5TK5cotjy2').should == 'Strong NE Winds!'
  end
end

describe MarkII do
  it "should shift alphabets by given count" do
    code_breaker = MarkII.new(2, 5)

    code_breaker.cipher('abc').should == 'STU'
    code_breaker.decipher('STU').should == 'abc'
  end
end

describe MarkIV do
  it "should decode" do
    code_breaker = MarkIV.new(4, 7)

    MarkIV.new(2, 5).cipher('abc').should == 'SWZ'
    code_breaker.cipher('The white cliffs of Alghero are visible at night').should == "JMl0kBp?20QixoivSc.2\"vvmls8KOk\"0jA,4kgt0OmUb,pm."
    code_breaker.decipher("JMl0kBp?20QixoivSc.2\"vvmls8KOk\"0jA,4kgt0OmUb,pm.").should == 'The white cliffs of Alghero are visible at night'
    code_breaker.decipher("WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\\\"SOQTNA8A\\\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I").should == "The rockets will strike at coordinates 49.977984 7.9257857 422979.83 5536735.81 on Oct. 7th"
  end
end

describe SeekingMarkIV do
  it "should decode" do
    code_breaker = SeekingMarkIV.new

    code_breaker.decipher("QT4e8MJYVhkls.27BL9,.MSqYSi'IUpAJKWg9Ul9p4o8oUoGy'ITd4d0AJVsLQp4kKJB2rz4dxfahwUa\"Wa.MS!k4hs2yY3k8ymnla.MOTxJ6wBM7sC0srXmyAAMl9t\"Wk4hs2yYTtH0vwUZp4a\"WhB2u,o6.!8Zt\"Wf,,eh5tk8WXv9UoM99w2Vr4!.xqA,5MSpWl9p4kJ2oUg'6evkEiQhC'd5d4k0qA'24nEqhtAQmy37il9p4o8vdoVr!xWSkEDn?,iZpw24kF\"fhGJZMI8nkI")
                .should == "We must defend Furlin at all costs or the war will be lost! The supreme leader is in a secret BUNKER in Western FURLIN.  In this secret bunker he is preparing his new plans for world domination as the star of many YouTube satire videos.  By the way, does anybody here speak Russian?"
  end
end