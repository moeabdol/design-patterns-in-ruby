require "forwardable"

class WriterDecorator
  extend Forwardable

  def_instance_delegators :@real_writer, :write_line, :pos, :rewind, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end
end
