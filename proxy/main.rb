require_relative "bank_account"
require_relative "bank_account_protection_proxy"
require_relative "bank_account_virtual_proxy"

# Bank account
account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)
puts "Bank Account: #{account.balance}"

# Bank account protection proxy
protection_proxy = BankAccountProtectionProxy.new(account, "moeabdol")
protection_proxy.deposit(50)
protection_proxy.withdraw(10)
puts "Bank Account Protection Proxy: #{protection_proxy.balance}"

# Bank account virtual proxy
virtual_proxy = BankAccountVirtualProxy.new { BankAccount.new(10) }
virtual_proxy.deposit(50)
virtual_proxy.withdraw(10)
puts "Bank Account Virtual Proxy: #{virtual_proxy.balance}"
