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

  def cipher(plain_message)
    plain_message.each_char.inject('') {|msg, char| msg + char.bytes.first.shift_character(@shift_count, @@keyboard)}
  end
end

class Fixnum
  def shift_character shift_count, keyboard
    index = keyboard.index(chr) + shift_count
    return keyboard[index] if index < keyboard.length
    keyboard[index % keyboard.length]
  end
end