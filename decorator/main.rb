require_relative "simple_writer"
require_relative "writer_decorator"
require_relative "time_stamping_writer"
require_relative "numbering_writer"
require_relative "check_summing_writer"

writer = CheckSummingWriter.new(TimeStampingWriter.new( \
          NumberingWriter.new(SimpleWriter.new("decorator/out.txt"))))
writer.write_line("Hello out there!")
writer.write_line("This is the decorator pattern in ruby.")
writer.close
puts "Checksum: #{writer.checksum}"
