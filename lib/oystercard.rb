class Oystercard
  attr_reader :balance, :entry_station, :journey_history

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def touch_in(station)
    raise "Your current balance is less than the minumum fare" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @entry_station = nil
    @exit_station = station
  end

  private
    def deduct(amount)
      @balance -= amount
    end
end
