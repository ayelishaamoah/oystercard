require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:balance) }

  it 'balance can be topped up' do
    expect(subject.top_up(10)).to eq 10
  end
end
