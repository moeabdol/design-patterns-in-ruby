class AbstractFactory
  def get_shape
    raise NotImplementedError
  end

  def get_color
    raise NotImplementedError
  end
end
