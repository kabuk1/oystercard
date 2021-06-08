require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double :station }

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

  # it 'can deduct fare from my card' do
  #   expect{ oystercard.deduct 25 }.to change{ oystercard.balance}.by -25
  # end

  context 'when starting journey' do

    it 'is not a journey to start' do
      expect(oystercard).not_to be_in_journey
    end

    it 'can touch in' do
      oystercard.touch_in(station)
      expect(oystercard).to be_in_journey
    end

    it "can check minimum balance on touch in" do
      min_limit = Oystercard::MIN_LIMIT
      error_msg = "You have insufficient funds!"
      oystercard.top_up(min_limit)
      expect { oystercard.touch_in(station) }.to raise_error(error_msg)
    end

    it 'can remember the entry station' do
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end

  context 'when ending a journey' do

    it 'can touch out' do
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it "can charge for the journey" do
      fare = Oystercard::FARE
      oystercard.touch_in(station)
      expect { oystercard.touch_out }.to change { oystercard.balance }.by -fare
    end

  end

end

# In order to pay for my journey
# As a customer
# I need to know where I've travelled from
# oystercard.touch_in
# expect oystercard