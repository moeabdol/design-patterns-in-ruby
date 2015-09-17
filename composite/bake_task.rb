class BakeTask < Task
  def initialize
    super("Bake")
  end

  def time_required
    42.0
  end
end
