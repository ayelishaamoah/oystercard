require 'oystercard'

describe Oystercard do

let(:entry_station) { double :station  }
let(:exit_station) { double :station  }

  describe '#initialize' do
    it 'has an empty list of journeys by default' do
      expect(subject.journey_history).to be_empty
    end
  end

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
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_in' do
    let(:journey){ {entry: entry_station, exit: exit_station} }

      it 'should record the entry station' do
        subject.top_up(25)
        expect(subject.touch_in(entry_station)).to eq({ entry: entry_station })
      end
      it 'stores a journey' do
        subject.top_up(25)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journey_history).to include journey
      end

    it 'throws an error if balance is lower than minimun fare' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Your current balance is less than the minumum fare"
    end
  end

  describe '#touch_out' do
    let(:journey){ {entry: entry_station, exit: exit_station} }

    it 'should update the card status to not be in journey' do
      subject.top_up(50)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'should deduct the fare from the current balance' do
      subject.top_up(50)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by (- Oystercard::MIN_BALANCE)
    end

    it 'should record the exit station' do
      subject.top_up(25)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include journey
    end
  end
end
