require "observer"

class Employee
  include Observable

  attr_reader :name, :position, :salary

  def initialize(options={})
    super()
    @name = options.fetch(:name, "")
    @position = options.fetch(:position, "")
    @salary = options.fetch(:salary, 0)
  end

  def name=(name)
    changed
    @name = name
    notify_observers(self)
  end

  def position=(position)
    changed
    @position = position
    notify_observers(self)
  end

  def salary=(salary)
    changed
    @salary = salary
    notify_observers(self)
  end
end
