require 'byebug'

class Guesser
  attr_accessor :chooser
  attr_accessor :initial_guesses

  def initialize(word)
    @chooser = word
    # https://en.wikipedia.org/wiki/Letter_frequency#Relative_frequencies_of_letters_in_the_English_language
    # combination of guesses, based on the most frequent letters in english language
    @initial_guesses = %w[ETAO INSH RDLC UMWF GYPB VKJX QZQZ]
  end

  # Entry point for the script. Masked to implemented other guessing strategies w/ ease
  def guess(method = :replacement)
    @chooser.clear_guesses

    guess = case method
            when :brute_force
              brute_force
            else
              replacement_method
    end
    puts "Found #{guess[:guess]} in #{@chooser.guess_count} guesses"
    guess[:guess]
  end

  private

  def replacement_method
    candidates = []

    # this is a letter that is not in the chosen word
    letter_not_used = nil

    # first phase, where we try to find at least 4 words w/ 1 cow
    # this phase will discard all the letters not present in the chosen word
    @initial_guesses.each do |guess|
      feedback = @chooser.check_guess(guess)

      # will only return if user enters one of the initial guesses
      return feedback if feedback[:bulls] == 4

      # if user entered one of the initial guesses in different order
      if feedback[:cows] == 4
        candidates.push(feedback)
        break
      end

      letter_not_used = guess.split('').sample if letter_not_used.nil? && feedback[:bulls] == 0 && feedback[:cows] == 0
      candidates.push(feedback) if feedback[:bulls] > 0 || feedback[:cows] > 0
    end

    # this block replaces every letter of every word with the unused letters
    # so that we can discard the letters that do not affect the score
    candidates.each do |cand|
      word = cand[:guess]
      (0..3).each do |i|
        l = word[i]
        word[i] = letter_not_used

        r = @chooser.check_guess(word)

        # if replacing the letter lowers the score, then l is a letter from
        # the chosen word. In that case, let's restore it.
        word[i] = l if r[:cows] < cand[:cows]
        word[i] = l if r[:bulls] < cand[:bulls]
      end
    end

    # all the remaining letters are accumulated in a set,
    # and the unused letter is removed from the array
    tmp = candidates.reduce([]) { |acum, cand| acum + cand[:guess].split('') }
    letters = tmp.reject {|l| l == letter_not_used}

    best_guess = nil

    # now check the permutation of just 4 letters to find the chosen word
    # score == 20 when 4 bulls are
    letters.to_a.permutation(4).each do |group|
      r = @chooser.check_guess(group.join(''))
      best_guess = r if r[:score] == 20
    end

    best_guess
  end

  def brute_force
    candidates = []

    # first phase, where we try to find at least 4 words w/ 1 cow
    # this phase will discard all the letters not present in the chosen word
    @initial_guesses.each do |guess|
      feedback = @chooser.check_guess(guess)

      # will only return if user enters one of the initial guesses
      return feedback if feedback[:bulls] == 4

      # if user entered one of the initial guesses in different order
      if feedback[:cows] == 4
        candidates.push(feedback)
        break
      end

      candidates.push(feedback) if feedback[:bulls] > 0 || feedback[:cows] > 0
    end

    # phase 2, where we test the permutations of the candidates
    tmp = candidates.reduce('') { |g, c| c[:guess] + g }
    guesses = tmp.split('').permutation(4)

    best_guess = nil

    guesses.each do |guess|
      result = @chooser.check_guess(guess.join(''))
      if best_guess.nil?
        best_guess = result
      else
        best_guess = result if best_guess[:score] < result[:score]
      end
      break if result[:score] == 20
    end

    best_guess
  end
end
