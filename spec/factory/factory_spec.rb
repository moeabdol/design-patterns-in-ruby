require_relative "../../factory/shape"
require_relative "../../factory/circle"
require_relative "../../factory/square"
require_relative "../../factory/rectangle"
require_relative "../../factory/shape_factory"

describe Shape do
  it "raises NotImpelementedError when calling draw method" do
    shape = Shape.new
    expect{ shape.draw }.to raise_error(NotImplementedError)
  end
end

describe Circle do
  it "draws circle to stdout" do
    circle = Circle.new
    expect{ circle.draw }.to output("Inside Circle::draw() method.\n").to_stdout
  end
end

describe Square do
  it "draws square to stdout" do
    square = Square.new
    expect{ square.draw }.to output("Inside Square::draw() method.\n").to_stdout
  end
end

describe Rectangle do
  it "draws rectangle to stdout" do
    rectangle = Square.new
    expect{ rectangle.draw }.to \
      output("Inside Square::draw() method.\n").to_stdout
  end
end

describe ShapeFactory do
  before(:all) { @factory = ShapeFactory.new }

  it "creates circle" do
    circle = @factory.get_shape("circle")
    expect(circle).to be_a(Circle)
  end

  it "creates square" do
    square = @factory.get_shape("square")
    expect(square).to be_a(Square)
  end

  it "creates rectangle" do
    rectangle = @factory.get_shape("rectangle")
    expect(rectangle).to be_a(Rectangle)
  end

  it "returns nil with unknown shapes" do
    unknown = @factory.get_shape("unknown")
    expect(unknown).to be_nil
  end
end
