require_relative 'wheels'

class MarkI
  def initialize(shift_count)
    @wheel = TransposeWheel.new shift_count
  end

  def cipher(message)
    @wheel.cipher(message)
  end
end