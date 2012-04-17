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

  def decipher(char)
    char.bytes.first.shift_character(@shift_count, @@keyboard)
  end
end

class ReverseTransposeWheel < Wheel
  def initialize(reverse_shift_count)
    @reverse_shift_count = reverse_shift_count * 2
  end

  def decipher(char)
    char.bytes.first.unshift_character(@reverse_shift_count, @@keyboard)
  end
end