class Oystercard
  attr_reader :balance

  MAX_LIMIT = 90
  MIN_LIMIT = 1
  FARE = 2

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Exceeds top-up limit of  £#{MAX_LIMIT}!" if amount + balance > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "You have insufficient funds!" if @balance == MIN_LIMIT
    @in_journey = true
  end

  def touch_out
    deduct(FARE)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
