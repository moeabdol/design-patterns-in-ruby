require_relative "../../../iterator/enumerable/account"
require_relative "../../../iterator/enumerable/portfolio"

describe "Enumerable" do
  describe Account do
    let(:account) { Account.new("my account", 100) }

    it "has name 'my account'" do
      expect(account.name).to eq("my account")
    end

    it "has balance 100" do
      expect(account.balance).to eq(100)
    end

    it "is comparable" do
      account1 = Account.new("account1", 100)
      account2 = Account.new("account2", 200)
      expect(account1 <=> account2).to eq(-1)
    end
  end

  describe Portfolio do
    before(:example) do
      @account1 = Account.new("account1", 100)
      @account2 = Account.new("account2", 200)
      @portfolio = Portfolio.new
    end

    it "has no accounts by default" do
      expect(@portfolio.length).to eq(0)
    end

    it "can add account" do
      @portfolio << @account1
      expect(@portfolio.length).to eq(1)
    end

    it "can remove account" do
      @portfolio << @account1
      @portfolio.remove_account(@account1)
      expect(@portfolio.length).to eq(0)
    end

    it "iterates over accounts using each method" do
      @portfolio << @account1
      @portfolio << @account2
      i = 0
      @portfolio.each do |account|
        expect(account).to eq(@portfolio.accounts[i])
        i += 1
      end
    end

    it "can sort accounts" do
      @portfolio << @account2
      @portfolio << @account1
      accounts = @portfolio.sort!
      expect(accounts[0].balance).to eq(100)
      expect(accounts[1].balance).to eq(200)
    end

    it "can sort accounts in-place" do
      @portfolio << @account2
      @portfolio << @account1
      @portfolio.sort!
      expect(@portfolio.accounts[0].balance).to eq(100)
      expect(@portfolio.accounts[1].balance).to eq(200)
    end
  end
end
