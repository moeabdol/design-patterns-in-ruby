class RedCircleFactory < AbstractFactory
  def get_shape
    Circle.new
  end

  def get_color
    Red.new
  end
end
