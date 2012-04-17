require_relative 'spec_helper'

describe "whole thing" do
  it "should solve the puzzle" do
    command = StartingQuestion.new
    while command.respond_to? :solve
      command = command.solve
    end
  end
end

describe StartingQuestion do
  it "should get the first question" do
    StartingQuestion.should_receive(:get).with('/start').and_return(:response)
    Question1.should_receive(:new).with(:response).and_return(:question)

    StartingQuestion.new.solve.should be :question
  end
end

describe Question1 do
  it "should get the next question" do
    question = Question1.new({'question' => 'Strong NE Winds!', 'reference-url' => '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'})

    code_breaker = stub
    MarkI.stub(:new).with(6).and_return(code_breaker)
    code_breaker.stub(:cipher).with('Strong NE Winds!').and_return(:answer)

    Question1.should_receive(:put).with('/14f7ca5f6ff1a5afb9032aa5e533ad95', {:body=>'{"answer":"answer"}'}).and_return(:response)
    Question2.should_receive(:new).with(:response).and_return(:question)

    question.solve.should == :question
  end
end

describe Question2 do
  it "should get the next question" do
    question = Question2.new({'question' => 'The Desert Fox will move 30 tanks to Calais at dawn', 'reference-url' => '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'})

    code_breaker = stub
    MarkII.stub(:new).with(9, 3).and_return(code_breaker)
    code_breaker.stub(:cipher).with('The Desert Fox will move 30 tanks to Calais at dawn').and_return(:answer)

    Question2.should_receive(:put).with('/14f7ca5f6ff1a5afb9032aa5e533ad95', {:body=>'{"answer":"answer"}'}).and_return(:response)
    Question3.should_receive(:new).with(:response).and_return(:question)

    question.solve.should == :question
  end
end

describe Question3 do
  it "should get the next question" do
    question = Question3.new({'question' => 'The white cliffs of Alghero are visible at night', 'reference-url' => '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'})

    code_breaker = stub
    MarkIV.stub(:new).with(4, 7).and_return(code_breaker)
    code_breaker.stub(:cipher).with('The white cliffs of Alghero are visible at night').and_return(:answer)

    Question3.should_receive(:put).with('/14f7ca5f6ff1a5afb9032aa5e533ad95', {:body=>'{"answer":"answer"}'}).and_return(:response)
    Question4.should_receive(:new).with(:response).and_return(:question)

    question.solve.should == :question
  end
end

describe Question4 do
  it "should get the next question" do
    question = Question4.new({'question' => "WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\"SOQTNA8A\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I", 'reference-url' => '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'})

    code_breaker = stub
    MarkIV.stub(:new).with(7, 2).and_return(code_breaker)
    code_breaker.stub(:decipher).with("WZyDsL3u'0TfxP06RtSSF 'DbzhdyFIAu2 zF f5KE\"SOQTNA8A\"NCKPOKG5D9GSQE'M86IGFMKE6'K4pEVPK!bv83I").and_return(:answer)

    Question4.should_receive(:put).with('/14f7ca5f6ff1a5afb9032aa5e533ad95', {:body=>'{"answer":"answer"}'}).and_return(:response)
    FinalQuestion.should_receive(:new).with(:response).and_return(:question)

    question.solve.should == :question
  end
end

describe FinalQuestion do
  it "should get the next question" do
    question = FinalQuestion.new({'code' => "final_question", 'reference-url' => '/questions/14f7ca5f6ff1a5afb9032aa5e533ad95.html'})

    code_breaker = stub
    SeekingMarkIV.stub(:new).and_return(code_breaker)
    code_breaker.stub(:decipher).with("final_question").and_return(:answer)

    question.solve.should == :answer
  end
end

describe "wheels" do
  describe ReverseTransposeWheel do
    it "should decipher" do
      ReverseTransposeWheel.new(2).decipher('!', nil).should_not be_nil
    end
  end
end

