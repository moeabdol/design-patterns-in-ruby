require_relative "../../strategy/newsletter"
require_relative "../../strategy/text"
require_relative "../../strategy/html"
require_relative "../../strategy/haml"

describe Newsletter do
  it "reads news file" do
    newsletter = Newsletter.new("strategy/news.csv", :text)
    expect(newsletter.head).to eq("Hello World,")
    expect(newsletter.content).to eq("This is the latest news!")
  end

  it "renders text newsletter" do
    newsletter = Newsletter.new("strategy/news.csv", :text)
    expect(newsletter.render).to include("Hello World,")
    expect(newsletter.render).to include("This is the latest news!")
  end

  it "renders html newsletter" do
    newsletter = Newsletter.new("strategy/news.csv", :html)
    expect(newsletter.render).to include("Hello World,")
    expect(newsletter.render).to include("This is the latest news!")
  end

  it "renders haml newsletter" do
    newsletter = Newsletter.new("strategy/news.csv", :haml)
    expect(newsletter.render).to include("Hello World,")
    expect(newsletter.render).to include("This is the latest news!")
  end
end
