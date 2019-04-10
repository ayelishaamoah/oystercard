class Oystercard
  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
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

  def touch_out
    deduct(MIN_BALANCE)
    @entry_station = nil
  end

  private
    def deduct(amount)
      @balance -= amount
    end
end
