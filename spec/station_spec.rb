require 'station'

describe Station do
  subject(:station) { described_class.new(name: "Waterloo", zone: 1) }

  it "initializes with a name" do
    expect(station.name).to eq("Waterloo")
  end

  it "initializes with a zone" do
    expect(station.zone).to eq(1)
  end

end
