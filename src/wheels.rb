module Minisculus
  module Keyboard
    @@keyboard = [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
        "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        ".", ",", "?", "!", "'", "\"", " "
    ]
  end
end

class TransposeWheel
  include Minisculus::Keyboard

  def initialize(shift_count)
    @shift_count = shift_count
  end

  def cipher(char, plain_message)
    char.bytes.first.shift_character(@shift_count, @@keyboard)
  end

  def decipher(char, decrypted_message)
    char.bytes.first.unshift_character(@shift_count, @@keyboard)
  end
end

class ReverseTransposeWheel
  include Minisculus::Keyboard

  def initialize(reverse_shift_count)
    @reverse_shift_count = reverse_shift_count * 2
  end

  def cipher(char, plain_message)
    char.bytes.first.unshift_character(@reverse_shift_count, @@keyboard)
  end

  def decipher(char, decrypted_message)
    char.bytes.first.shift_character(@reverse_shift_count, @@keyboard)
  end
end

class HistoryBasedWheel
  include Minisculus::Keyboard

  def initialize
    @characters_seen = -1
  end

  def cipher(char, plain_message)
    last_position = @characters_seen == -1 ? 0 : @@keyboard.index(plain_message[@characters_seen])
    @characters_seen += 1
    char.bytes.first.shift_character(2 * last_position, @@keyboard)
  end

  def decipher(char, decrypted_message)
    last_position = decrypted_message.empty? ? 0 : @@keyboard.index(decrypted_message[-1])
    char.bytes.first.unshift_character(2 * last_position, @@keyboard)
  end
end


class Fixnum
  def shift_character shift_count, keyboard
    index = keyboard.index(chr) + shift_count
    return keyboard[index] if index < keyboard.length
    keyboard[index % keyboard.length]
  end

  def unshift_character shift_count, keyboard
    index = keyboard.index(chr) - shift_count
    return keyboard[index] unless index < 0
    keyboard[keyboard.length + index]
  end
end