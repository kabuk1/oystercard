require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it 'shows the card balance' do
    expect(oystercard.balance).to eq(0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'can top-up the card balance' do
    expect{ oystercard.top_up 5 }.to change{ oystercard.balance }.by 5
  end

  it 'raises and error when top-up limit exceeded' do
    expect{ oystercard.top_up 100 }.to raise_error 'Exceeds top-up limit of £90'
  end

  it 'can deduct fare from my card' do
    expect{ oystercard.deduct 25 }.to change{ oystercard.balance}.by -25
  end

end
