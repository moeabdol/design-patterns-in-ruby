require_relative "employee"
require_relative "payroll"

employee = Employee.new(name: "mohd", position: "programmer", salary: 10000)
payroll = Payroll.new
employee.add_observer(payroll)
employee.name = "Mohammad"
employee.position = "Software Engineer"
employee.salary = 1000000
