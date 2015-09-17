require_relative "composite_command"
require_relative "create_file"
require_relative "copy_file"
require_relative "delete_file"
require "FileUtils"

installation_wizard = CompositeCommand.new
installation_wizard << CreateFile.new("command/file1.txt", "hello world\n")
installation_wizard << CopyFile.new("command/file1.txt", "command/file2.txt")
installation_wizard << DeleteFile.new("command/file1.txt")

puts installation_wizard.description
installation_wizard.execute

sleep 1.5
installation_wizard.unexecute
