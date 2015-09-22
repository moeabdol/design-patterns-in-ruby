require_relative "../../singleton/simple_logger.rb"
require_relative "../../singleton/class_as_singleton/class_based_logger.rb"

def read_last_line_in_file_to_string(path)
  if File.exists?(path)
    content = ""
    File.readlines(path).each { |line| content = line }
    content
  end
end

def read_file_to_string(path)
  if File.exists?(path)
    file = File.open(path)
    content = file.read
    file.close
  end
  content
end

describe SimpleLogger do
  after(:all) { File.delete("singleton/log.txt") }

  context "no logging levels" do
    it "does not log warning" do
      SimpleLogger.instance.level = SimpleLogger::ERROR
      SimpleLogger.instance.warning("warning occured!")
      content = read_file_to_string("singleton/log.txt")
      expect(content).to eq("")
    end

    it "does not log info" do
      SimpleLogger.instance.level = SimpleLogger::WARNING
      SimpleLogger.instance.info("info occured!")
      content = read_file_to_string("singleton/log.txt")
      expect(content).to eq("")
    end
  end

  context "logging levels" do
    it "logs errors" do
      SimpleLogger.instance.level = SimpleLogger::ERROR
      SimpleLogger.instance.error("error occured!")
      content = read_last_line_in_file_to_string("singleton/log.txt")
      expect(content).to eq("error occured!\n")
    end

    it "logs warning" do
      SimpleLogger.instance.level = SimpleLogger::WARNING
      SimpleLogger.instance.warning("warning occured!")
      content = read_last_line_in_file_to_string("singleton/log.txt")
      expect(content).to eq("warning occured!\n")
    end

    it "logs info" do
      SimpleLogger.instance.level = SimpleLogger::INFO
      SimpleLogger.instance.info("info occured!")
      content = read_last_line_in_file_to_string("singleton/log.txt")
      expect(content).to eq("info occured!\n")
    end
  end
end

describe ClassBasedLogger do
  after(:all) { File.delete("singleton/class_as_singleton/log.txt") }

  context "no logging levels" do
    it "does not log warining" do
      ClassBasedLogger.level = ClassBasedLogger::ERROR
      ClassBasedLogger.warning("warning occured!")
      content = read_file_to_string("singleton/class_as_singleton/log.txt")
      expect(content).to eq("")
    end

    it "does not log info" do
      ClassBasedLogger.level = ClassBasedLogger::WARNING
      ClassBasedLogger.info("info occured!")
      content = read_file_to_string("singleton/class_as_singleton/log.txt")
      expect(content).to eq("")
    end
  end

  context "logging levels" do
    it "does log error" do
      ClassBasedLogger.level = ClassBasedLogger::INFO
      ClassBasedLogger.error("error occured!")
      content = \
        read_last_line_in_file_to_string("singleton/class_as_singleton/log.txt")
      expect(content).to eq("error occured!\n")
    end

    it "does log warning" do
      ClassBasedLogger.level = ClassBasedLogger::WARNING
      ClassBasedLogger.warning("warning occured!")
      content = \
        read_last_line_in_file_to_string("singleton/class_as_singleton/log.txt")
      expect(content).to eq("warning occured!\n")
    end

    it "does log info" do
      ClassBasedLogger.level = ClassBasedLogger::INFO
      ClassBasedLogger.info("info occured!")
      content = \
        read_last_line_in_file_to_string("singleton/class_as_singleton/log.txt")
      expect(content).to eq("info occured!\n")
    end
  end
end
