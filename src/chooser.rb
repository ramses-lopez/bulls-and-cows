# frozen_string_literal: true

class Chooser
  attr_accessor :word
  attr_accessor :dictionary
  attr_accessor :guess_count

  def initialize(entry)
    @word = entry.upcase
    @guess_count = 0
    validate
    build_dictionary
  end

  def clear_guesses
    @guess_count = 0
  end

  # returns how many cows & bulls are contained in guess, and the score for this
  # particular guess. Each Bull adds 5 points to the score, while each cow adds 1 point.
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
    @guess_count += 1
    { guess: guess, cows: cows, bulls: bulls, score: (bulls * 5 + cows) }
  end

  private

  def validate
    raise 'Word must have 4 letters' unless @word.size == 4
    raise 'Only letters are allowed' unless /[a-zA-Z]{4}/.match @word
  end

  def build_dictionary
    @dictionary = {}
    @word.split('').each_with_index do |letter, idx|
      raise 'Word must not have duplicate letters' if @dictionary.key? letter
      @dictionary[letter] = idx
    end
  end
end
