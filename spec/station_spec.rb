require 'station'

describe Station do
  let(:name) { double(:name) }
  let(:zone) { double(:zone) }
  subject(:station) { described_class.new(name, zone) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:zone) }

  describe '#initialize' do
    it "initializes with a name" do
      expect(station.name).to eq name
    end

    it "initializes with a zone" do
      expect(station.zone).to eq zone
    end
  end
end
