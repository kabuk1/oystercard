require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#start' do
    it 'sets an entry_station variable ' do
      journey.start(entry_station)
      expect(journey.entry_station).to eq(entry_station)
    end
  end

  describe '#end' do
    it 'ends the journey' do
      journey.start(entry_station)
      journey.end(exit_station)
      expect(journey.entry_station).to eq(nil)
    end
  end

  describe '#fare' do
    it 'returns the journey cost at the end of the journey' do
      journey.start(entry_station)
      journey.end(exit_station)
      expect(journey.fare).to eq(Journey::MIN_FARE)
    end
  end
end