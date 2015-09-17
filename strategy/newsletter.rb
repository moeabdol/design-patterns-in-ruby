class Newsletter
  attr_reader :head, :content

  def initialize(file, format)
    @file = file
    @format = format
    @head = ""
    @content = ""
    read_file
  end

  def read_file
    File.readlines(@file).each do |line|
      @head, @content = line.chomp.split(", ")
    end
  end

  def render
    strategy = Object.const_get(@format.to_s.capitalize).new
    strategy.generate(self)
  end
end
