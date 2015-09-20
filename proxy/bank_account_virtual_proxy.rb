class BankAccountVirtualProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def subject
    @subject ||= @creation_block.call
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  def balance
    subject.balance
  end
end
