require_relative "m_bank_account"
require_relative "m_bank_account_protection_proxy"
require_relative "m_bank_account_virtual_proxy"

# Bank account
account = MBankAccount.new(100)
account.deposit(50)
account.withdraw(35)
puts "Bank Account: #{account.balance}"

# Bank account protection proxy
protection_proxy = MBankAccountProtectionProxy.new(account, "moeabdol")
protection_proxy.deposit(5)
protection_proxy.withdraw(20)
puts "Bank account protection proxy: #{protection_proxy.balance}"

# Bank account virtual proxy
virtual_proxy = MBankAccountVirtualProxy.new{ MBankAccount.new(200) }
virtual_proxy.deposit(500)
virtual_proxy.withdraw(600)
puts "Bank account virtual proxy: #{virtual_proxy.balance}"
