require './src/guesser'
require './src/chooser'

RSpec.describe 'Guesser' do

  def guess(word, method)
    Guesser.new(Chooser.new(word)).guess(method)
  end

  it 'should find the chosen word through brute force' do
    puts '--------- brute_force'
    chosen_word = 'CATS'
    expect(guess(chosen_word, :brute_force)).to eq(chosen_word)
    chosen_word = 'PARK'
    expect(guess(chosen_word, :brute_force)).to eq(chosen_word)
    chosen_word = 'FOXY'
    expect(guess(chosen_word, :brute_force)).to eq(chosen_word)
    chosen_word = 'AXES'
    expect(guess(chosen_word, :brute_force)).to eq(chosen_word)
  end

  it 'should find the chosen word through replacement' do
    puts '--------- replacement'
    chosen_word = 'CATS'
    expect(guess(chosen_word, :replacement)).to eq(chosen_word)
    chosen_word = 'PARK'
    expect(guess(chosen_word, :replacement)).to eq(chosen_word)
    chosen_word = 'FOXY'
    expect(guess(chosen_word, :replacement)).to eq(chosen_word)
    chosen_word = 'AXES'
    expect(guess(chosen_word, :replacement)).to eq(chosen_word)
  end

end
