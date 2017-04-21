class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys

  MAXIMUM_BALANCE = 100
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @journeys = []
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

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @in_journey = false
    # @entry_station = station
    @exit_station = station
    journey_hash
    nil
  end

  def in_journey?
    !!entry_station
  end

  def journey_hash
    @journeys << {"entry_station" => @entry_station, "exit_station" => @exit_station}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end


# card touches in and out, seperate information stored in
# instance variables, both go to nil when touch out
# next step is to store both values in a hash and record it in initialize.
