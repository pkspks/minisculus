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

  def cipher(char, msg)
    char.bytes.first.shift_character(@shift_count, @@keyboard)
  end

  def decipher(char, msg)
    char.bytes.first.unshift_character(@shift_count, @@keyboard)
  end
end

class ReverseTransposeWheel < Wheel
  def initialize(reverse_shift_count)
    @reverse_shift_count = reverse_shift_count * 2
  end

  def cipher(char, msg)
    char.bytes.first.unshift_character(@reverse_shift_count, @@keyboard)
  end

  def decipher(char, msg)
    char.bytes.first.shift_character(@reverse_shift_count, @@keyboard)
  end
end

class HistoryBasedWheel < Wheel
  def initialize
    @characters_seen = -1
  end

  def cipher(char, msg)
    last_position = @characters_seen == -1 ? 0 : @@keyboard.index(msg[@characters_seen])
    decoded_char = char.bytes.first.shift_character(2 * last_position, @@keyboard)
    @characters_seen += 1
    decoded_char
  end

  def decipher(char, msg)
    last_position = msg.empty? ? 0 : @@keyboard.index(msg[-1])
    decoded_char = char.bytes.first.unshift_character(2 * last_position, @@keyboard)
    decoded_char
  end
end


class Fixnum
  def shift_character shift_count, keyboard
    index = keyboard.index chr
    return keyboard[index + shift_count] unless index + shift_count >= keyboard.length
    keyboard[(index + shift_count) % keyboard.length]
  end

  def unshift_character shift_count, keyboard
    index = keyboard.index chr
    return keyboard[index - shift_count] unless index - shift_count < 0
    keyboard[keyboard.length + (index - shift_count)]
  end
end