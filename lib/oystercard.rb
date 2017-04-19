class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  MAXIMUM_BALANCE = 100
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "insufficent balance" if @balance < MINIMUM_FARE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
