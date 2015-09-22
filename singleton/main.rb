require_relative "simple_logger"

puts "Logger level: #{SimpleLogger.instance.level}"
SimpleLogger.instance.info("Computer wins chess game.")
SimpleLogger.instance.warning("AE-35 hardware faliure predicted.")
SimpleLogger.instance.error("HAL-9000 malfunction, take emergency action!")
