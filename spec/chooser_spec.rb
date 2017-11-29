# frozen_string_literal: true

require './src/chooser'

RSpec.describe 'Chooser' do
  it 'should return the number of cows & bulls from a guess' do
    c = Chooser.new('CATS')
    r = c.check_guess('HATS')
    expect(r[:score]).to eq(15)
    expect(r[:bulls]).to eq(3)
    expect(r[:cows]).to eq(0)

    r = c.check_guess('SALE')
    expect(r[:score]).to eq(6)
    expect(r[:bulls]).to eq(1)
    expect(r[:cows]).to eq(1)
  end

  it 'should validate the size of the word' do
    expect { Chooser.new('FIGHT') }.to raise_error(RuntimeError, 'Word must have 4 letters')
  end

  it 'should validate that only numbers are entered ' do
    expect { Chooser.new('FIG1') }.to raise_error(RuntimeError, 'Only letters are allowed')
  end

  it 'should uppercase any entry' do
    c = Chooser.new('love')
    expect(c.word).to eq('LOVE')
  end

  it 'should not allow duplicate letters' do
    expect { Chooser.new('bell') }.to raise_error(RuntimeError, 'Word must not have duplicate letters')
  end
end
