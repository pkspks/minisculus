require File.expand_path("../helper/spec_helper", __FILE__)

describe StartingQuestion do
   it "should get the first question" do
     command = StartingQuestion.new
     while command.respond_to? :solve
       command = command.solve
     end

   end
end
describe Question1 do
  it "should solve first problem" do
    solver = Question1.new({'question' => 'Strong NE Winds!', 'reference-url' => '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'})
    solver.solve
  end
end

describe Question2 do
  it "should solve problem" do
    "solving #<Question2:0x007fc412c98a28 @question=\"The Desert Fox will move 30 tanks to Calais at dawn\", @post_url=\"/questions/2077f244def8a70e5ea758bd8352fcd8.html\">"
    "answer Wkh2Ghvhuw2Ir.2zloo2pryh2632wdqnv2wr2Fdodlv2dw2gdzq"
  end
end

describe Question4 do
  it "should solve problem" do
    solver = Question4.new({'question' => "WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\\\"SOQTNA8A\\\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I", 'reference-url' => '/questions/4baecf8ca3f98dc13eeecbac263cd3ed.html'})
    solver.solve
  end
end

describe FinalQuestion do
  it "should solve problem" do
    solver = FinalQuestion.new({"code"=>"QT4e8MJYVhkls.27BL9,.MSqYSi'IUpAJKWg9Ul9p4o8oUoGy'ITd4d0AJVsLQp4kKJB2rz4dxfahwUa\"Wa.MS!k4hs2yY3k8ymnla.MOTxJ6wBM7sC0srXmyAAMl9t\"Wk4hs2yYTtH0vwUZp4a\"WhB2u,o6.!8Zt\"Wf,,eh5tk8WXv9UoM99w2Vr4!.xqA,5MSpWl9p4kJ2oUg'6evkEiQhC'd5d4k0qA'24nEqhtAQmy37il9p4o8vdoVr!xWSkEDn?,iZpw24kF\"fhGJZMI8nkI",
                            "email"=>"minisculus@minisculuschallenge.com", "reference-url"=>"/finish/50763edaa9d9bd2a9516280e9044d885.html"})
    solver.solve
  end
end

describe ReverseTransposeWheel do
  it "should decipher" do
    ReverseTransposeWheel.new(2).decipher('!', nil).should_not be_nil
  end
end

