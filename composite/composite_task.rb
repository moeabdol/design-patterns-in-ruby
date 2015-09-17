require_relative "task"

class CompositeTask < Task
  attr_reader :sub_tasks

  def initialize(title)
    super(title)
    @sub_tasks = []
  end

  def add_sub_task(sub_task)
    @sub_tasks << sub_task
  end

  alias :<< :add_sub_task

  def remove_sub_task(sub_task)
    @sub_tasks.delete(sub_task)
  end

  def [](index)
    @sub_tasks[index]
  end

  def []=(index, sub_task)
    @sub_tasks[index] = sub_task
  end

  def time_required
    total_time = 0.0
    @sub_tasks.each { |sub_task| total_time += sub_task.time_required }
    total_time
  end
end
