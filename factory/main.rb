require_relative "shape_factory"
require_relative "shape"
require_relative "circle"
require_relative "square"
require_relative "rectangle"

shape_factory = ShapeFactory.new

circle = shape_factory.get_shape("circle")
circle.draw

square = shape_factory.get_shape("square")
square.draw

rectangle = shape_factory.get_shape("rectangle")
rectangle.draw
