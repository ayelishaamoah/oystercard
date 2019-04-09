class Oystercard
  attr_reader :balance

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance + amount > MAX_BALANCE

    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Your current balance is less than the minumum fare" if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_BALANCE)
    @in_journey = false
  end

  private
    def deduct(amount)
      @balance -= amount
    end
end
