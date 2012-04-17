require_relative 'code_breakers'
require_relative 'code_cracker'

class StartingQuestion
  include Minisculus::Contact

  def solve
    response = self.class.get('/start')
    Question1.new response
  end
end

class Question1
  include ::Minisculus::CodeCracking

  def answer
    MarkI.new(6).cipher(@encrypted_message)
  end

  def next_question response
    Question2.new response
  end
end

class Question2
  include ::Minisculus::CodeCracking

  def answer
    MarkII.new(9, 3).cipher(@encrypted_message)
  end

  def next_question response
    Question3.new response
  end
end

class Question3
  include ::Minisculus::CodeCracking

  def answer
    MarkIV.new(4, 7).cipher(@encrypted_message)
  end

  def next_question response
    Question4.new response
  end
end

class Question4
  include ::Minisculus::CodeCracking

  def answer
    MarkIV.new(7, 2).decipher(@encrypted_message)
  end

  def next_question response
    FinalQuestion.new response
  end
end

class FinalQuestion
  include Minisculus::Contact
  include Minisculus::OpensInBrowser

  def initialize(params)
    @encrypted_message = params['code']
    @get_url = params['reference-url']
  end

  def solve
    open_in_browser @get_url
    puts "cracking the final code - #{@encrypted_message}"
    puts "decoded message : \n--------\n #{answer}\n--------"
    answer
  end

  def answer
    SeekingMarkIV.new.decipher(@encrypted_message)
  end
end