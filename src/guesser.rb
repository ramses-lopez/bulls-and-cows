
class Guesser
  attr_accessor :chooser
  #https://en.wikipedia.org/wiki/Letter_frequency#Relative_frequencies_of_letters_in_the_English_language
  # combination of guesses, based on the most frequent letters in english language
  @@initial_guesses = ['ETAO', 'INSH', 'RDLC', 'UMWF', 'GYPB', 'VKJX', 'QZJX']

  def initialize(word)
    @chooser = word
  end

  def guess(method = :brute_force)
    @chooser.clear_guesses
    guess = brute_force
    puts "Found #{guess[:guess]} in #{@chooser.guess_count} guesses"
  end

  private

  def brute_force
    candidates = []
    #first phase, where we try to find at least 4 words w/ 1 cow
    @@initial_guesses.each do |guess|
      feedback = @chooser.check_guess(guess)

      if feedback[:bulls] == 4
        puts "***The word is #{guess}!!***"
        puts "Word found in #{@chooser.guess_count} guesses"
        exit
      end

      if feedback[:cows] == 4
        puts '4 cows! we should scramble ' + guess
        candidates.push feedback
        break
      end

      candidates.push feedback if feedback[:bulls] > 0 || feedback[:cows] > 0
    end

    tmp = candidates.reduce('') {|g, c| c[:guess] + g }

    guesses = tmp.split('').permutation(4)

    best_guess = nil

    guesses.each do |guess|
      result = @chooser.check_guess(guess.join(''))
      unless best_guess.nil?
        best_guess = result if best_guess[:score] < result[:score]
      else
        best_guess = result
      end
      break if result[:score] == 20
    end

    return best_guess
  end
end
