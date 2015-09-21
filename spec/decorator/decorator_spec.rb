require_relative "../../decorator/simple_writer"
require_relative "../../decorator/writer_decorator"
require_relative "../../decorator/time_stamping_writer"
require_relative "../../decorator/numbering_writer"
require_relative "../../decorator/check_summing_writer"

def read_string_from_file(path)
  if File.exists?(path)
    reader = File.open(path)
    content = reader.read
    reader.close
  end
  content
end

describe SimpleWriter do
  before(:example) do
    @path = "decorator/out.txt"
    @writer = SimpleWriter.new(@path)
    @writer.write_line("hello")
  end

  after(:example) { File.delete(@path) }

  it "should write line to file" do
    @writer.close
    content = read_string_from_file(@path)
    expect(content).to eq("hello\n")
  end

  it "should report correct position" do
    expect(@writer.pos).to eq(6)
    @writer.close
  end

  it "should rewind to begining" do
    @writer.rewind
    expect(@writer.pos).to eq(0)
  end
end

describe WriterDecorator do
  before(:example) do
    @path = "decorator/out.txt"
    @real_writer = SimpleWriter.new(@path)
    @decorator = WriterDecorator.new(@real_writer)
  end

  after(:example) { File.delete(@path) }

  it "delegates write_line method to real_writer" do
    expect(@real_writer).to receive(:write_line).with("hello world")
    @decorator.write_line("hello world")
    @decorator.close
  end

  it "real_writer actually writes line to file" do
    @decorator.write_line("hello world")
    @decorator.close
    content = read_string_from_file(@path)
    expect(content).to eq("hello world\n")
  end

  it "delegates pos method to real_writer" do
    expect(@real_writer).to receive(:pos).and_return(12)
    @decorator.write_line("hello world")
    @decorator.pos
    @decorator.close
  end

  it "real_writer reports correct position" do
    @decorator.write_line("hello world")
    expect(@real_writer.pos).to eq(12)
    @decorator.close
  end

  it "delegates rewind method to real_writer" do
    expect(@real_writer).to receive(:rewind).and_return(0)
    @decorator.write_line("hello world")
    @decorator.rewind
    @decorator.close
  end

  it "real_writer reports position is 0" do
    @decorator.write_line("hello world")
    @decorator.rewind
    expect(@decorator.pos).to eq(0)
    @decorator.close
  end

  it "delegates close method to real_writer" do
    expect(@real_writer).to receive(:close)
    @decorator.close
  end
end

describe TimeStampingWriter do
  before(:example) do
    @path = "decorator/out.txt"
    @real_writer = SimpleWriter.new(@path)
    @time_stamp_writer = TimeStampingWriter.new(@real_writer)
  end

  after(:example) { File.delete(@path) }

  it "real_writer writes time stamped lines to file" do
    @time_stamp_writer.write_line("hello world")
    @time_stamp_writer.close
    content = read_string_from_file(@path)
    expect(content).to eq("#{Time.new}: hello world\n")
  end
end

describe NumberingWriter do
  before(:example) do
    @path = "decorator/out.txt"
    @real_writer = SimpleWriter.new(@path)
    @numbering_writer = NumberingWriter.new(@real_writer)
  end

  after(:example) { File.delete(@path) }

  it "real_writer writes numbered lines to file" do
    @numbering_writer.write_line("hello")
    @numbering_writer.write_line("world")
    @numbering_writer.close
    content = read_string_from_file(@path)
    expect(content).to eq("1: hello\n2: world\n")
  end
end

describe CheckSummingWriter do
  before(:example) do
    @path = "decorator/out.txt"
    @real_writer = SimpleWriter.new(@path)
    @checksum_writer = CheckSummingWriter.new(@real_writer)
  end

  after(:example) { File.delete(@path) }

  it "real_writer writes line to file" do
    @checksum_writer.write_line("hello world")
    @checksum_writer.close
    content = read_string_from_file(@path)
    expect(content).to eq("hello world\n")
  end

  it "calculates checksum correctly" do
    @checksum_writer.write_line("hello world")
    @checksum_writer.close
    expect(@checksum_writer.checksum).to eq(10)
  end
end
