class Generator
  attr_reader :head, :content

  def initialize(file)
    @head = ""
    @content = ""
    @file = file
    read_file
  end

  def read_file
    File.readlines(@file).each do |line|
      @head, @content = line.chomp.split(", ")
    end
  end

  def render
    raise NotImplementedError
  end
end
