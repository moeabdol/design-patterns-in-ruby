require_relative "module_based_logger"

puts "Logger level: #{ModuleBasedLogger.level}"
ModuleBasedLogger.info("Computer wins chess game.")
ModuleBasedLogger.warning("AE-35 hardware failure predicted.")
ModuleBasedLogger.error("HAL-9000 malfunction, take emergency action!")
