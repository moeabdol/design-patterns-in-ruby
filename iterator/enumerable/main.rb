require_relative "account"
require_relative "portfolio"

account1 = Account.new("account1", 100)
account2 = Account.new("account2", 200)
account3 = Account.new("account3", 300)
portfolio = Portfolio.new

portfolio << account3
portfolio << account1
portfolio << account2

puts "not sorted"
portfolio.each { |account| puts "#{account.name} #{account.balance}" }
puts

portfolio.sort!
puts "sorted"
portfolio.each { |account| puts "#{account.name} #{account.balance}" }
puts

puts "does portfolio has any account with balance > 200"
puts portfolio.any? { |account| account.balance > 200 }
puts

puts "does all portfolio accounts have balance > 10"
puts portfolio.all? { |account| account.balance > 10 }
