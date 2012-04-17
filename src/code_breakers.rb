require_relative 'wheels'

class CodeBreaker
  def initialize *wheels
    @wheels = wheels
  end

  def cipher(message)
    message.each_byte.inject('') { |msg, chi|
      ch = chi.chr
      msg+@wheels.inject(ch) { |c, wheel|
        wheel.cipher(c, message)
      }
    }
  end

  def decipher(message)
    wheels = @wheels.reverse
    message.each_char.inject('') { |msg, ch|
      msg+wheels.inject(ch) { |c, wheel|
        wheel.decipher(c, msg)
      }
    }
  end
end

class MarkI < CodeBreaker
  def initialize(shift_count)
    super(TransposeWheel.new shift_count)
  end
end

class MarkII < CodeBreaker
  def initialize(shift_count, reverse_shift_count)
    super(TransposeWheel.new(shift_count), ReverseTransposeWheel.new(reverse_shift_count))
  end
end

class MarkIV < CodeBreaker
  def initialize(shift_count, reverse_shift_count)
    super(TransposeWheel.new(shift_count), ReverseTransposeWheel.new(reverse_shift_count), HistoryBasedWheel.new)
  end
end