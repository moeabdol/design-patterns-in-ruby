require_relative "command"

class CompositeCommand < Command
  attr_reader :commands

  def initialize
    @commands = []
  end

  def add_command(command)
    @commands << command
  end

  alias :<< :add_command

  def remove_command(command)
    @commands.delete(command)
  end

  def execute
    @commands.each { |command| command.execute }
  end

  def unexecute
    @commands.reverse.each { |command| command.unexecute }
  end

  def description
    description = ""
    @commands.each { |command| description += command.description + "\n"}
    description
  end
end
