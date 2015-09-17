require_relative "../../template/generator"
require_relative "../../template/generators/text"
require_relative "../../template/generators/html"
require_relative "../../template/generators/haml"

describe Generator do
  it "reads news file" do
    newsletter_generator = Generator.new("template/news.csv")
    expect(newsletter_generator.head).to eq("Hello World,")
    expect(newsletter_generator.content).to eq("This is the latest news!")
  end

  it "does not implement render method" do
    newsletter_generator = Generator.new("template/news.csv")
    expect {
      newsletter_generator.render
    }.to raise_error(NotImplementedError)
  end

  context "generators" do
    it "renders newsletter in plain text format" do
      newsletter_text_generator = Generators::Text.new("template/news.csv")
      final_result = "Hello World,\nThis is the latest news!"
      expect(newsletter_text_generator.render).to eq(final_result)
    end

    it "renders newsletter in html format" do
      newsletter_html_generator = Generators::HTML.new("template/news.csv")
      final_result = "<h1>Hello World,</h1>\n<p>This is the latest news!</p>"
      expect(newsletter_html_generator.render).to eq(final_result)
    end

    it "renders newsletter in haml format" do
      newsletter_haml_generator = Generators::HAML.new("template/news.csv")
      final_result = "%h1 Hello World,\n%p This is the latest news!"
      expect(newsletter_haml_generator.render).to eq(final_result)
    end
  end
end
