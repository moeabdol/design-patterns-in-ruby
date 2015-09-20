require_relative "../../../proxy/using_messages/m_bank_account"
require_relative "../../../proxy/using_messages/m_bank_account_protection_proxy"
require_relative "../../../proxy/using_messages/m_bank_account_virtual_proxy"

describe "Proxy Pattern Using Messages" do
  describe MBankAccount do
    let(:account) { MBankAccount.new(100) }

    it "should deposit money" do
      account.deposit(50)
      expect(account.balance).to eq(150)
    end

    it "should withdraw money" do
      account.withdraw(25)
      expect(account.balance).to eq(75)
    end

    it "should query balance" do
      expect(account.balance).to eq(100)
    end
  end

  describe MBankAccountProtectionProxy do
    before(:all) do
      @account = MBankAccount.new
      @owner = "moeabdol"
      @account_proxy = MBankAccountProtectionProxy.new(@account, @owner)
    end

    it "allows owner access" do
      expect{ @account_proxy.check_access }.not_to raise_error
    end

    it "denies non-owner access" do
      another_account = MBankAccount.new
      another_owner = "mohammad"
      another_account_proxy = MBankAccountProtectionProxy.new(another_account,
                                                              another_owner)
      expect{ another_account_proxy.check_access }.to \
        raise_error("Illegal access: moeabdol cannot access account.")
    end

    it "delegates deposit to method_missing" do
      expect(@account_proxy).to receive(:method_missing).with(:deposit, 50)
      @account_proxy.deposit(50)
    end

    it "changes subject balance when deposit" do
      @account_proxy.deposit(50)
      expect(@account.balance).to eq(50)
    end

    it "delegates withdraw to method_missing" do
      expect(@account_proxy).to receive(:method_missing).with(:withdraw, 15)
      @account_proxy.withdraw(15)
    end

    it "changes subject balance when withdraw" do
      @account_proxy.withdraw(15)
      expect(@account.balance).to eq(35)
    end

    it "delegates balance to method_missing" do
      expect(@account_proxy).to receive(:method_missing).with(:balance)
      @account_proxy.balance
    end

    it "reports correct subject balance" do
      expect(@account.balance).to eq(35)
      expect(@account_proxy.balance).to eq(35)
    end
  end

  describe MBankAccountVirtualProxy do
    before(:all) do
      @account_proxy = MBankAccountVirtualProxy.new do
        MBankAccount.new
      end
    end

    it "should delegate desposit call to method_missing" do
      expect(@account_proxy).to receive(:method_missing).with(:deposit, 50)
      @account_proxy.deposit(50)
    end

    it "should change subject balance when deposit" do
      @account_proxy.deposit(50)
      expect(@account_proxy.subject.balance).to eq(50)
    end

    it "should delegate withdraw call to method_missing" do
      expect(@account_proxy).to receive(:method_missing).with(:withdraw, 15)
      @account_proxy.withdraw(15)
    end

    it "should change subject balance when withdraw" do
      @account_proxy.withdraw(15)
      expect(@account_proxy.subject.balance).to eq(35)
    end

    it "should delegate balance call to method_missing" do
      expect(@account_proxy).to \
        receive(:method_missing).with(:balance).and_return(35)
      @account_proxy.balance
    end

    it "should return real subject balance" do
      expect(@account_proxy.balance).to eq(35)
      expect(@account_proxy.subject.balance).to eq(35)
    end
  end
end
