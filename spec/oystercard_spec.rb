require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

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
    it 'has no previous journeys' do
      expect(oystercard.journeys).to be_empty
    end

    it 'is not a journey to start' do
      expect(oystercard).not_to be_in_journey
    end

    it 'can touch in' do
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    it "can check minimum balance on touch in" do
      min_limit = Oystercard::MIN_LIMIT
      error_msg = "You have insufficient funds!"
      oystercard.top_up(min_limit)
      expect { oystercard.touch_in(entry_station) }.to raise_error(error_msg)
    end

    it 'can stores the entry station' do
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end

  end

  context 'when ending a journey' do

    it 'can touch out' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'can charge for the journey' do
      fare = Oystercard::FARE
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by -fare
    end

    it 'can store an exit station' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq exit_station
    end

    it 'can store journeys' do
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include journey
    end

  end

end


