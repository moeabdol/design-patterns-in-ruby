require_relative "../../observer/employee"
require_relative "../../observer/payroll"

describe "observer" do
  before(:example) do
    @employee = Employee.new(name: "mohd",
                             position: "programmer",
                             salary: 10000)
    @payroll = Payroll.new
    @employee.add_observer(@payroll)
  end

  describe Employee do
    it "allows observers to register" do
      expect(@employee.count_observers).to eq(1)
    end

    it "notifies observers when salary changes" do
      expect(@payroll).to receive(:update)
      @employee.salary = 1000000
    end
  end

  describe Payroll do
    it "can register to an observable" do
      expect(@employee.count_observers).to eq(1)
    end

    it "gets notified when observable name changes" do
      expect(@payroll).to receive(:update)
      @employee.name = "mohammad"
    end
  end
end
