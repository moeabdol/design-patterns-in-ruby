class BlueRectangleFactory < AbstractFactory
  def get_shape
    Rectangle.new
  end

  def get_color
    Blue.new
  end
end
