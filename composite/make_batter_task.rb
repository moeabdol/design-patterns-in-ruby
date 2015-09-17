require_relative "composite_task"
require_relative "add_dry_ingredients_task"
require_relative "add_liquid_ingredients_task"
require_relative "mix_ingredients_task"

class MakeBatterTask < CompositeTask
  def initialize
    super("Make Batter")
    self << AddDryIngredientsTask.new
    self << AddLiquidIngredientsTask.new
    self << MixIngredientsTask.new
  end
end
