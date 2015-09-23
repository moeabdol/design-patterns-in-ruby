class ColoredShapeFactory
  def get_factory(type)
    if %w(RedCircle GreenSquare BlueRectangle).include? type
      self.class.const_get("#{type}Factory").new
    else
      nil
    end
  end
end
