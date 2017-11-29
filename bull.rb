# frozen_string_literal: true

require './src/guesser'
require './src/chooser'

# Guesser.new(Chooser.new('LOVE')).guess
# Guesser.new(Chooser.new('LISA')).guess
# Guesser.new(Chooser.new('HOME')).guess
# Guesser.new(Chooser.new('BEST')).guess

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

def get_input
  puts "\n"
  puts 'Enter your 4-letter word (or enter q to exit):'
  word = gets.chomp

  exit_game if word == 'q'

  begin
    best_guess = Guesser.new(Chooser.new(word)).guess
    puts "\n"
    puts 'Would you like to try again?'
    get_input
  rescue RuntimeError => e
    puts "There is something wrong with your entry: #{e.message}"
    puts 'Try again!'
    get_input
  end
end

intro
get_input
