class MixIngredientsTask < Task
  def initialize
    super("Mix Ingredients")
  end

  def time_required
    3.0
  end
end
