# frozen_string_literal: true

require './src/guesser'
require './src/chooser'

def intro
  puts '🐂🐂🐂 Bulls and Cows 🐄🐄🐄'
  puts "\n"
  puts 'Bulls and Cows is a word guessing game. Enter a four-letter word without duplicated letters, and I\'ll try to guess it'
  puts ''
end

def exit_game
  puts "\n"
  puts 'Bye! Thanks for playing!'
  exit
end

def mode_selection
  puts 'Enter 1 for auto-guessing mode, 2 for manual mode or q to exit:'
  mode = gets.chomp

  case mode
  when '1'
    auto_guess_mode
  when '2'
    manual_mode
  when 'q'
    exit_game
  else
    puts 'Invalid option'
    puts "\n"
    mode_selection
  end
end

def manual_mode
  puts "\n"

  chooser = Chooser.new(Chooser::WORD_LIST.sample)

  last_result = nil

  while(last_result.nil? || last_result[:score] != 20)
    last_result = get_player_input(chooser)
  end

end

def get_player_input(chooser)
  puts 'Try to guess the 4-letter word (or enter q to exit)'

  begin
    word = gets.chomp
    exit_game if word == 'q'
    puts "\n"

    result = chooser.check_guess(word)

    if result[:score] == 20
      puts "*** Congratulations! You found #{chooser.word} in #{chooser.guess_count} guesses! ***"
      puts "\n"
      mode_selection
    else
      puts "#{result[:guess]} -> #{result[:bulls]} bulls, #{result[:cows]} cows"
      puts "\n"
    end

  rescue RuntimeError => e
    puts "There is something wrong with your entry: #{e.message}"
    puts 'Try again!'
  end

end

def auto_guess_mode
  puts "\n"
  puts 'Enter a 4-letter word, and I will try to guess it (or enter q to exit):'
  word = gets.chomp

  exit_game if word == 'q'

  begin
    best_guess = Guesser.new(Chooser.new(word)).guess
    puts "\n"
    puts 'Would you like to try again?'
    puts "\n"
    mode_selection
  rescue RuntimeError => e
    puts "There is something wrong with your entry: #{e.message}"
    puts 'Try again!'
    auto_guess_mode
  end
end

intro
mode_selection
