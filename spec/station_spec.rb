require 'station'

describe Station do

  subject { described_class.new("name", 1) }

  it "has a name" do
    expect(subject.name).to eq "name"
  end

  it "has a zone" do
    expect(subject.zone).to eq 1
  end
end
