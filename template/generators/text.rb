module Generators
  class Text < Generator
    def render
      "#{@head}\n#{@content}"
    end
  end
end
