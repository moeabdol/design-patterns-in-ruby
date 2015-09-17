module Generators
  class HTML < Generator
    def render
      "<h1>#{@head}</h1>\n<p>#{@content}</p>"
    end
  end
end
