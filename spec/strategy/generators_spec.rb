require_relative "../../strategy/newsletter"
require_relative "../../strategy/text"
require_relative "../../strategy/html"
require_relative "../../strategy/haml"

describe "generators" do
  before(:example) do
    @newsletter = double(Newsletter)
    allow(@newsletter).to receive(:head).and_return("Hello World,")
    allow(@newsletter).to receive(:content).and_return("This is the latest " +
                                                       "news!")
  end

  context Text do
    it "generates valid plain text" do
      text_generator = Text.new
      expected = "Hello World,\nThis is the latest news!"
      expect(text_generator.generate(@newsletter)).to eq(expected)
    end
  end

  context Html do
    it "generates valid html" do
      html_generator = Html.new
      expected = "<h1>Hello World,</h1>\n<p>This is the latest news!</p>"
      expect(html_generator.generate(@newsletter)).to eq(expected)
    end
  end

  context Haml do
    it "generates valid haml" do
      haml_generator = Haml.new
      expected = "%h1 Hello World,\n%p This is the latest news!"
      expect(haml_generator.generate(@newsletter)).to eq(expected)
    end
  end
end
