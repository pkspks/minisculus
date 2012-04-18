require_relative 'code_breakers'
require 'httparty'
require 'json'

class StartingQuestion
  include Minisculus::Contact

  def solve
    response = self.class.get('/start')
    Question1.new response
  end
end

class Question1
  include Minisculus::Contact

  def initialize(params)
    @encrypted_message = params['question']
    @get_url = params['reference-url']
    @post_url = (/\/questions(\/.*?).html/.match @get_url)[1]
  end

  def solve
    puts "message - #{@encrypted_message}"
    puts "solution - #{answer}\n\n"
    response = send(:class).put(@post_url, body: {answer: answer}.to_json)
    next_question response
  end

  def answer
    MarkI.new(6).cipher(@encrypted_message)
  end

  def next_question response
    Question2.new response
  end
end

class Question2
  def initialize(params)
    @encrypted_message = params['question']
    @get_url = params['reference-url']
    @post_url = (/\/questions(\/.*?).html/.match @get_url)[1]
  end
end