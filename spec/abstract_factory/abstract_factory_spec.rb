require_relative "../../abstract_factory/color"
require_relative "../../abstract_factory/red"
require_relative "../../abstract_factory/blue"
require_relative "../../abstract_factory/green"
require_relative "../../abstract_factory/abstract_factory"
require_relative "../../abstract_factory/colored_shape_factory"
require_relative "../../abstract_factory/red_circle_factory"
require_relative "../../abstract_factory/green_square_factory"
require_relative "../../abstract_factory/blue_rectangle_factory"
require_relative "../../factory/shape"
require_relative "../../factory/circle"
require_relative "../../factory/square"
require_relative "../../factory/rectangle"

describe Color do
  it "raises NotImplementedError when calling fill method" do
    color = Color.new
    expect{ color.fill }.to raise_error(NotImplementedError)
  end
end

describe Red do
  it "fills red color to stdout" do
    red = Red.new
    expect{ red.fill }.to output("Inside Red::fill() method.\n").to_stdout
  end
end

describe Blue do
  it "fills blue color to stdout" do
    blue = Blue.new
    expect{ blue.fill }.to output("Inside Blue::fill() method.\n").to_stdout
  end
end

describe Green do
  it "fills green color to stdout" do
    green = Green.new
    expect{ green.fill }.to output("Inside Green::fill() method.\n").to_stdout
  end
end

describe AbstractFactory do
  before(:all) { @abstract_factory = AbstractFactory.new }

  it "raises NotImplementedError when get_shape() is called" do
    expect{ @abstract_factory.get_shape }.to raise_error(NotImplementedError)
  end

  it "raises NotImplementedError when get_color() is called" do
    expect{ @abstract_factory.get_color }.to raise_error(NotImplementedError)
  end
end

describe RedCircleFactory do
  before(:all) { @red_circle_factory = RedCircleFactory.new }

  it "returns Circle when get_shape is called" do
    expect(@red_circle_factory.get_shape).to be_a(Circle)
  end

  it "returns Red when get_color is called" do
    expect(@red_circle_factory.get_color).to be_a(Red)
  end
end

describe GreenSquareFactory do
  before(:all) { @green_square_factory = GreenSquareFactory.new }

  it "returns Circle when get_shape is called" do
    expect(@green_square_factory.get_shape).to be_a(Square)
  end

  it "returns Red when get_color is called" do
    expect(@green_square_factory.get_color).to be_a(Green)
  end
end

describe BlueRectangleFactory do
  before(:all) { @blue_rectangle_factory = BlueRectangleFactory.new }

  it "returns Circle when get_shape is called" do
    expect(@blue_rectangle_factory.get_shape).to be_a(Rectangle)
  end

  it "returns Red when get_color is called" do
    expect(@blue_rectangle_factory.get_color).to be_a(Blue)
  end
end

describe ColoredShapeFactory do
  before(:all) { @colored_shape_factory = ColoredShapeFactory.new }

  it "returns RedCircleFactory" do
    expect(@colored_shape_factory.get_factory("RedCircle")).to \
      be_a(RedCircleFactory)
  end

  it "returns GreenSquareFactory" do
    expect(@colored_shape_factory.get_factory("GreenSquare")).to \
      be_a(GreenSquareFactory)
  end

  it "returns BlueRectangleFactory" do
    expect(@colored_shape_factory.get_factory("BlueRectangle")).to \
      be_a(BlueRectangleFactory)
  end

  it "returns nil when unknown factory" do
    expect(@colored_shape_factory.get_factory("Unknown")).to be_nil
  end
end
