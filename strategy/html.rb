class Html
  def generate(context)
    "<h1>#{context.head}</h1>\n<p>#{context.content}</p>"
  end
end
