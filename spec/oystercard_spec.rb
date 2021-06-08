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
    max_limit = Oystercard::MAX_LIMIT
    error_msg ="Exceeds top-up limit of  £#{max_limit}!"
    oystercard.top_up(max_limit)
    expect{ oystercard.top_up 100 }.to raise_error(error_msg)
  end

  it 'can deduct fare from my card' do
    expect{ oystercard.deduct 25 }.to change{ oystercard.balance}.by -25
  end

  it 'is not a journey to start' do
    expect(oystercard).not_to be_in_journey
  end

  it 'can touch in' do
    oystercard.touch_in
    expect(oystercard).to be_in_journey
  end

  it 'can touch out' do
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard).not_to be_in_journey
  end

end
