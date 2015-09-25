require_relative "parser"

# using parser
parser = Parser.new("and(and(bigger 1024) (filename *.lock)) writable")
ast = parser.expression
puts "Find file(s): and(and(bigger 1024) (filename *.lock)) writable"
puts ast.evaluate(".")
