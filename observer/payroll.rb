class Payroll
  def update(observable)
    puts "Employee Name: #{observable.name}"
    puts "Employee Position: #{observable.position}"
    puts "Employee Salary: #{observable.salary}"
  end
end
