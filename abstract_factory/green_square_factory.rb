class GreenSquareFactory < AbstractFactory
  def get_shape
    Square.new
  end

  def get_color
    Green.new
  end
end
