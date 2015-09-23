class ShapeFactory
  def get_shape(shape)
    if %w(circle square rectangle).include? shape
      self.class.const_get(shape.capitalize).new
    else
      nil
    end
  end
end
