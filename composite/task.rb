class Task
  attr_reader :title

  def initialize(title)
    @title = title
  end

  def time_required
    0.0
  end
end
