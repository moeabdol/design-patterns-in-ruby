require_relative "../../proxy/bank_account"
require_relative "../../proxy/bank_account_protection_proxy"
require_relative "../../proxy/bank_account_virtual_proxy"

describe "Proxy Pattern" do
  describe BankAccount do
    before(:all) { @account = BankAccount.new }

    it "has initial balance of 0" do
      expect(@account.balance).to eq(0)
    end

    it "can deposit money" do
      @account.deposit(50)
      expect(@account.balance).to eq(50)
    end

    it "can withdraw money" do
      @account.withdraw(15)
      expect(@account.balance).to eq(35)
    end
  end

  describe BankAccountProtectionProxy do
    before(:all) do
      @account = BankAccount.new
      @owner = "moeabdol"
      @account_proxy = BankAccountProtectionProxy.new(@account, @owner)
    end

    it "allows owner access" do
      expect{ @account_proxy.check_access }.not_to raise_error
    end

    it "denies non-owner access" do
      another_account = BankAccount.new
      another_owner = "mohammad"
      another_account_proxy = BankAccountProtectionProxy.new(another_account,
                                                             another_owner)
      expect{ another_account_proxy.check_access }.to \
        raise_error("Illegal access: moeabdol cannot access account.")
    end

    it "delegates deposit method to subject" do
      expect(@account).to receive(:deposit).with(50)
      @account_proxy.deposit(50)
    end

    it "changes subject balance upon deposit" do
      @account_proxy.deposit(50)
      expect(@account.balance).to eq(50)
    end

    it "delegates withdraw method to subject" do
      expect(@account).to receive(:withdraw).with(15)
      @account_proxy.withdraw(15)
    end

    it "changes subject balance upon withdrawal" do
      @account_proxy.withdraw(15)
      expect(@account.balance).to eq(35)
    end

    it "delegates balance query to subject" do
      expect(@account).to receive(:balance).and_return(35)
      @account_proxy.balance
    end

    it "reports correct account balance when queried" do
      expect(@account.balance).to eq(35)
    end
  end

  describe BankAccountVirtualProxy do
    before(:all) do
      @account_proxy = BankAccountVirtualProxy.new do
        BankAccount.new
      end
    end

    it "should delegate deposit call to subject" do
      expect(@account_proxy.subject).to receive(:deposit).with(50)
      @account_proxy.deposit(50)
    end

    it "should affect subject balance when deposit" do
      @account_proxy.deposit(50)
      expect(@account_proxy.subject.balance).to eq(50)
    end

    it "should delegate withdraw call to subject" do
      expect(@account_proxy.subject).to receive(:withdraw).with (15)
      @account_proxy.withdraw(15)
    end

    it "should affect subject balance when withdraw" do
      @account_proxy.withdraw(15)
      expect(@account_proxy.subject.balance).to eq(35)
    end

    it "should delegate balance call to subject" do
      expect(@account_proxy.subject).to receive(:balance).and_return(35)
      @account_proxy.balance
    end

    it "should return real subject balance" do
      expect(@account_proxy.balance).to eq(35)
      expect(@account_proxy.subject.balance).to eq(35)
    end
  end
end
