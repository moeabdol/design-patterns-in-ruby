class BankAccount
  attr_reader :balance

  def initialize(initial_balance=0)
    @balance = initial_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end
