class CopyFile < Command
  def initialize(source, destination)
    super("Copy File: #{source} to #{destination}")
    @source = source
    @destination = destination
  end

  def execute
    if File.exist?(@destination)
      @content = File.read(@destination)
    end
    FileUtils.copy(@source, @destination)
  end

  def unexecute
    if @content
      file = File.open(@destination, "w")
      file.write(@content)
      file.close
    else
      File.delete(@destination)
    end
  end
end
