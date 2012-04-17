require 'httparty'
require 'json'
require_relative 'simple_cipher'


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
      @question = params['question']
      @post_url = params['reference-url']
    end

    def solve
      p "solving #{inspect}"
      p "answer #{answer}"
      open_in_browser
      response = send(:class).put((/\/questions(\/.*?).html/.match @post_url)[1], options: {headers: {'ContentType' => 'application/json'}}, body: {answer: answer}.to_json)
      next_question response
    end

    def open_in_browser
      p send(:class).get(@post_url)
      #system "open 'http://minisculuschallenge.com#{@post_url}'"
    end
  end
end


class Question1
  include ::Minisculus::ProblemSolving

  def answer
    MarkI.new(6).decipher(@question)
  end

  def next_question response
    Question2.new response
  end
end

class Question2
  include ::Minisculus::ProblemSolving

  def answer
    MarkII.new(9, 3).decipher(@question)
  end

  def next_question response
    p response
  end
end

class StartCommand
  include HTTParty
  base_uri 'http://minisculuschallenge.com'

  def solve
    response = self.class.get('/start')
    Question1.new response
  end
end

