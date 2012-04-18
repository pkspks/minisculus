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