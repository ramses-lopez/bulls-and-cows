require './src/guesser'
require './src/chooser'

Guesser.new(Chooser.new('LOVE')).guess
Guesser.new(Chooser.new('LISA')).guess
Guesser.new(Chooser.new('HOME')).guess
Guesser.new(Chooser.new('BEST')).guess
