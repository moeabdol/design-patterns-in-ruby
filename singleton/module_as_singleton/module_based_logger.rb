module ModuleBasedLogger
  ERROR = 1
  WARNING = 2
  INFO = 3

  @@level = WARNING

  def self.log
    @@log ||= File.open("singleton/module_as_singleton/log.txt", "w")
  end

  def self.level=(new_level)
    @@level = new_level
  end

  def self.level
    @@level
  end

  def self.error(msg)
    log.puts(msg)
    log.flush
  end

  def self.warning(msg)
    log.puts(msg) if @@level >= WARNING
    log.flush
  end

  def self.info(msg)
    log.puts(msg) if @@level >= INFO
    log.flush
  end
end
