class Oystercard

  def initialize
    @balance = 0
  end

  attr_reader :balance

  def top_up(amount)
    @balance += amount
    raise "Maximum balance of #{MAX_BALANCE} exceeded" if @balance > MAX_BALANCE

    @balance
  end

  private
  MAX_BALANCE = 90

end
