require 'httparty'
require 'json'

module Minisculus
  module Contact
    def self.included(base)
      @base = base
      @base.class_eval do
        include HTTParty
        base_uri 'http://minisculuschallenge.com'
      end
    end
  end

  module OpensInBrowser
    def open_in_browser url
      #system "open 'http://minisculuschallenge.com#{url}'"
    end
  end

  module CodeCracking
    def self.included(base)
      base.send(:include, Contact)
      base.send(:include, OpensInBrowser)
    end

    def initialize(params)
      @encrypted_message = params['question']
      @get_url = params['reference-url']
      @post_url = (/\/questions(\/.*?).html/.match @get_url)[1]
    end

    def solve
      open_in_browser @get_url
      puts "message - #{@encrypted_message}"
      puts "solution - #{answer}\n\n"
      response = send(:class).put(@post_url, body: {answer: answer}.to_json)
      next_question response
    end
  end
end