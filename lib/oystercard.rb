class Oystercard
  LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Exceeds top-up limit of £90" if amount + balance > LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
