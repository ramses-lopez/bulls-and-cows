require 'pry'

class Chooser
  attr_accessor :word
  attr_accessor :dictionary

  def initialize(entry)
    @word = entry.upcase
    validate
    build_dictionary
  end

  # returns how many cows & bulls are contained in guess
  def check_guess(guess)
    bulls = 0
    cows = 0
    guess.upcase.split('').each_with_index do |letter, idx|
      if @dictionary.keys.include?(letter)
        if letter == @dictionary.keys[idx]
          bulls += 1
        else
          cows += 1
        end
      end
    end
    {guess: guess, cows: cows, bulls: bulls}
  end

  private

  def validate
    raise 'Word must have 4 letters' unless @word.size == 4
  end

  def build_dictionary
    @dictionary = {}
    @word.split('').each_with_index do |letter, idx|
      raise 'Word must not have duplicate letters' if @dictionary.key? letter
      @dictionary[letter] = idx
    end
  end

end

word1 = Chooser.new('LOVE')
puts word1.check_guess('LEPE')
