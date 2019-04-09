require 'oystercard'

describe Oystercard do

  describe '#top_up' do
    it 'balance can be topped up' do
      expect{ subject.top_up(25) }.to change{ subject.balance }.by +25
    end

    it 'fails if user tries to exceed maximum balance' do
      expect{ subject.top_up(95) }.to raise_error("Maximum balance of #{Oystercard::MAX_BALANCE} exceeded")
    end
  end

  describe '#deduct' do
    it 'allows the user to deduct money from the balance' do
      subject.top_up(50)
      expect{ subject.deduct(25) }.to change{ subject.balance }.by -25
    end
  end

  describe '#in_journey?' do
    it 'should return true if the card is being used' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'should update the card status to be in journey' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'should update the card status to be in journey' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
