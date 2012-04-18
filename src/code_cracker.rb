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
end