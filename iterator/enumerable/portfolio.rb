class Portfolio
  include Enumerable

  attr_accessor :accounts

  def initialize
    @accounts = []
  end

  def length
    @accounts.length
  end

  def add_account(account)
    @accounts << account
  end

  alias :<< :add_account

  def remove_account(account)
    @accounts.delete(account)
  end

  def each(&block)
    accounts.each(&block)
  end

  def sort
    accounts.sort
  end

  def sort!
    @accounts = accounts.sort
  end
end
