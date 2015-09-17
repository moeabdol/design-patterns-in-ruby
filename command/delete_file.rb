class DeleteFile < Command
  def initialize(path)
    super("Delete File: #{path}")
    @path = path
  end

  def execute
    if File.exist?(@path)
      @content = File.read(@path)
      File.delete(@path)
    end
  end

  def unexecute
    if @content
      file = File.open(@path, "w")
      file.write(@content)
      file.close
    end
  end
end
