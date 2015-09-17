module Generators
  class HAML < Generator
    def render
      "%h1 #{@head}\n%p #{@content}"
    end
  end
end
