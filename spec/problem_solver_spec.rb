require File.expand_path("../helper/spec_helper", __FILE__)

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
    "solving #<Question4:0x007fd28158e638 @question=\"WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\\\"SOQTNA8A\\\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I\", @post_url=\"/questions/4baecf8ca3f98dc13eeecbac263cd3ed.html\">"
  end
end

describe StartCommand do
   it "should get the first question" do
     command = StartCommand.new
     until command.nil?
       command = command.solve
     end

   end
end