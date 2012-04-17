require 'httparty'
require 'json'
require_relative 'code_breakers'

module Minisculus
  module ProblemSolving

    def self.included(base)
      @base = base
      @base.class_eval do
        include HTTParty
        base_uri 'http://minisculuschallenge.com'
      end
    end

    def initialize(params)
      @encrypted_message = params['question']
      @get_url = params['reference-url']
      @post_url = (/\/questions(\/.*?).html/.match @get_url)[1]
    end

    def solve
      puts "solving - #{@encrypted_message}"
      puts "answer - #{answer}\n\n"
      open_in_browser
      response = send(:class).put(@post_url, options: {headers: {'ContentType' => 'application/json'}}, body: {answer: answer}.to_json)
      #p "got #{response}"
      next_question response
    end

    def open_in_browser
      #p send(:class).get(@get_url)
      #system "open 'http://minisculuschallenge.com#{@get_url}'"
    end
  end
end

class Question1
  include ::Minisculus::ProblemSolving

  def answer
    MarkI.new(6).cipher(@encrypted_message)
  end

  def next_question response
    Question2.new response
  end
end

class Question2
  include ::Minisculus::ProblemSolving

  def answer
    MarkII.new(9, 3).cipher(@encrypted_message)
  end

  def next_question response
    Question3.new response
  end
end

class Question3
  include ::Minisculus::ProblemSolving

  def answer
    MarkIV.new(4, 7).cipher(@encrypted_message)
  end

  def next_question response
    Question4.new response
  end
end

class Question4
  include ::Minisculus::ProblemSolving

  def answer
    MarkIV.new(7, 2).decipher(@encrypted_message)
  end

  def next_question response
    FinalQuestion.new response
  end
end

class FinalQuestion
  include ::Minisculus::ProblemSolving

  def initialize(params)
    @encrypted_message = params['code']
    @get_url = params['reference-url']
    @email = params['email']
    @post_url = (/\/finish(\/.*?).html/.match @get_url)[1]
  end

  def solve
    open_in_browser
    puts "cracking the final code - #{@encrypted_message}"
    puts "decoded message : \n--------\n #{SeekingMarkIV.new.decipher(@encrypted_message)}\n------------"
  end
end

class StartingQuestion
  include HTTParty
  base_uri 'http://minisculuschallenge.com'

  def solve
    response = self.class.get('/start')
    Question1.new response
  end
end

