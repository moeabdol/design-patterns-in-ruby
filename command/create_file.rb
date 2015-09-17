class CreateFile < Command
  def initialize(path, content)
    super("Create File: #{path}")
    @path = path
    @content = content
  end

  def execute
    file = File.open(@path, "w")
    file.write(@content)
    file.close
  end

  def unexecute
    if File.exist?(@path)
      File.delete(@path)
    end
  end
end
