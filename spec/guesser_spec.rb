require './src/guesser'

RSpec.describe 'Guesser' do

  it 'should find the chosen word through brute force' do
    chosen_word = 'CATS'
    c = Chooser.new(chosen_word)
    word = Guesser.new(c).guess(:brute_force)
    expect(word).to eq(chosen_word)
  end

end
