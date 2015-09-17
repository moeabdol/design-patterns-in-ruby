class Haml
  def generate(context)
    "%h1 #{context.head}\n%p #{context.content}"
  end
end
