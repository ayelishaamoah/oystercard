class Oystercard
  attr_reader :balance, :entry_station, :journey_history

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @journey = {}
  end

  def top_up(amount)
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    @journey.length == 1 ? true : false
  end

  def touch_in(station)
    raise "Your current balance is less than the minumum fare" if @balance < MIN_BALANCE
    @journey = {}
    @journey[:entry] = station
    @journey
  end

  def touch_out(station)
    deduct(MIN_BALANCE)
    @journey[:exit] = station
    @journey_history << @journey
    @journey_history
  end

  private
    def deduct(amount)
      @balance -= amount
    end
end
