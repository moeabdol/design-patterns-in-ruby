require_relative "composite_task"
require_relative "make_batter_task"
require_relative "fill_pan_task"
require_relative "bake_task"
require_relative "frost_task"

class MakeCakeTask < CompositeTask
  def initialize
    super("Make Cake")
    self << MakeBatterTask.new
    self << FillPanTask.new
    self << BakeTask.new
    self << FrostTask.new
  end
end
