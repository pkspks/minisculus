class CodeBreaker
   def initialize *wheels
     @wheels = wheels
   end

   def decipher(message)
     @wheels.inject(message) {|msg, wheel| wheel.decipher(msg) }
   end
end

class Wheel
  @@keyboard = [
      "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
      "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
      "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
      "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
      ".", ",", "?", "!", "'", "\"", " "
  ]
end

class TransposeWheel < Wheel
  def initialize(shift_count)
    @shift_count = shift_count
  end

  def decipher(message)
    message.each_byte.inject('') { |mem, x| mem+=x.shift_character(@shift_count, @@keyboard); mem }
  end
end

class ReverseTransposeWheel < Wheel
  def initialize(reverse_shift_count)
    @reverse_shift_count = reverse_shift_count * 2
  end

  def decipher(message)
    message.each_byte.inject('') { |mem, x| mem+=x.unshift_character(@reverse_shift_count, @@keyboard); mem }
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

class Fixnum

  def shift_unshift_character shift_count, unshift_count, keyboard
    shift_character(shift_count, keyboard).bytes.first.unshift_character(unshift_count, keyboard)
  end

  def shift_character shift_count, keyboard
    index = keyboard.index chr
    return keyboard[index + shift_count] unless index + shift_count > keyboard.length
    keyboard[(index + shift_count) % keyboard.length]
  end

  def unshift_character shift_count, keyboard
    index = keyboard.index chr
    return keyboard[index - shift_count] unless index - shift_count < 0
    keyboard[keyboard.length + (index - shift_count)]
  end
end