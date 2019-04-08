require 'oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:balance) }

end
