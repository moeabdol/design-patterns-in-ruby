class NumberingWriter < WriterDecorator
  def write_line(line)
    @line_number ||= 1
    @real_writer.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end
