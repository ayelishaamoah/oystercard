require 'oystercard'

describe Oystercard do

let(:station) { double :station }

  describe '#top_up' do
    it 'balance can be topped up' do
      expect{ subject.top_up(25) }.to change{ subject.balance }.by +25
    end

    it 'fails if user tries to exceed maximum balance' do
      expect{ subject.top_up(95) }.to raise_error("Maximum balance of #{Oystercard::MAX_BALANCE} exceeded")
    end
  end

  describe '#in_journey?' do
    it 'should return true if the card is being used' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'should update the card status to be in journey' do
      subject.top_up(50)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

      it 'should record the entry station' do
        subject.top_up(25)
        expect(subject.touch_in(station)).to eq(station)
      end

    it 'throws an error if balance is lower than minimun fare' do
      expect{ subject.touch_in(station) }.to raise_error "Your current balance is less than the minumum fare"
    end
  end

  describe '#touch_out' do
    it 'should update the card status to not be in journey' do
      subject.top_up(50)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'should deduct the fare from the current balance' do
      expect { subject.touch_out }.to change{ subject.balance }.by (- Oystercard::MIN_BALANCE)
    end
  end
end
