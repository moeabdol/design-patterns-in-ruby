class CheckSummingWriter < WriterDecorator
  attr_reader :checksum

  def write_line(line)
    @checksum ||= 0
    line.each_byte { |byte| @check_sum = (@checksum + byte) %256 }
    @checksum += "\n".ord % 256
    @real_writer.write_line(line)
  end
end
