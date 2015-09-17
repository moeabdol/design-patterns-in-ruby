require_relative "../../command/command"
require_relative "../../command/composite_command"
require_relative "../../command/create_file"
require_relative "../../command/copy_file"
require_relative "../../command/delete_file"

def delete_file(path)
  if File.exist?(path)
    File.delete(path)
  end
end

def create_file(path, content)
  file = File.open(path, "w")
  file.write(content)
  file.close
end

describe Command do
  let(:command) { Command.new("my description") }

  it "has a description" do
    expect(command.description).to eq("my description")
  end

  it "raises NotImplementedError when calling execute method" do
    expect{ command.execute }.to raise_error(NotImplementedError)
  end

  it "raises NotImplementedError when calling unexecute method" do
    expect{ command.unexecute }.to raise_error(NotImplementedError)
  end
end

describe CompositeCommand do
  context "add/remove sub-commands" do
    before(:example) do
      @command1 = Command.new("command1")
      @command2 = Command.new("command2")
      @composite_command = CompositeCommand.new
      @composite_command << @command1
      @composite_command << @command2
    end

    it "can add commands" do
      expect(@composite_command.commands.length).to eq(2)
    end

    it "can remove commands" do
      @composite_command.remove_command(@command1)
      expect(@composite_command.commands).not_to include(@command1)
    end
  end

  context "execute/unexecute sub-commands" do
    before(:example) do
      @command1 = double(:CustomCommand)
      @command2 = double(:CustomCommand)
      allow(@command1).to receive(:execute)
      allow(@command2).to receive(:execute)
      allow(@command1).to receive(:unexecute)
      allow(@command2).to receive(:unexecute)
      @composite_command = CompositeCommand.new
      @composite_command << @command1
      @composite_command << @command2
    end

    it "executes commands in-order" do
      expect(@command1).to receive(:execute).ordered
      expect(@command2).to receive(:execute).ordered
      @composite_command.execute
    end

    it "unexecutes commands in reverse-order" do
      expect(@command2).to receive(:unexecute).ordered
      expect(@command1).to receive(:unexecute).ordered
      @composite_command.unexecute
    end
  end

  it "show description of sub-commands" do
    command1 = Command.new("command1 description")
    command2 = Command.new("command2 description")
    composite_command = CompositeCommand.new
    composite_command << command1
    composite_command << command2
    description = "command1 description\ncommand2 description\n"
    expect(composite_command.description).to eq(description)
  end
end

describe CreateFile do
  before(:example) do
    @path = "command/test_file.txt"
    @content = "sample content"
    delete_file(@path)
  end

  after(:example) { delete_file(@path) }

  it "creates file in path when execute is called" do
    create_file_command = CreateFile.new(@path, @content)
    create_file_command.execute
    expect(File.exist?(@path)).to be true
  end

  it "deletes file in path when unexecute is called" do
    create_file_command = CreateFile.new(@path, @content)
    create_file_command.execute
    create_file_command.unexecute
    expect(File.exist?(@path)).to be false
  end
end

describe CopyFile do
  context "copy source file to new destination file" do
    before(:example) do
      @source = "command/source.txt"
      @destination = "command/destination.txt"
      delete_file(@destination)
      create_file(@source, "source content")
      @copy_file_command = CopyFile.new(@source, @destination)
    end

    after(:example) do
      delete_file(@source)
      delete_file(@destination)
    end

    it "copy file" do
      @copy_file_command.execute
      expect(File.exist?(@destination)).to be true
      expect(File.read(@destination)).to eq("source content")
    end

    it "uncopy file" do
      @copy_file_command.execute
      @copy_file_command.unexecute
      expect(File.exist?(@destination)).to be false
    end
  end

  context "copy source file to existing destination file" do
    before(:example) do
      @source = "command/source.txt"
      @destination = "command/destination.txt"
      create_file(@source, "source content")
      create_file(@destination, "destination content")
      @copy_file_command = CopyFile.new(@source, @destination)
    end

    after(:example) do
      delete_file(@source)
      delete_file(@destination)
    end

    it "copy file" do
      @copy_file_command.execute
      expect(File.exist?(@destination)).to be true
      expect(File.read(@destination)).to eq("source content")
    end

    it "uncopy file" do
      @copy_file_command.execute
      @copy_file_command.unexecute
      expect(File.exist?(@destination)).to be true
      expect(File.read(@destination)).to eq("destination content")
    end
  end
end

describe DeleteFile do
  context "file to delete dosn't exist" do
    before(:example) do
      @path = "command/test_file.txt"
      @delete_file_command = DeleteFile.new(@path)
    end

    after(:example) { delete_file(@path) }

    it "deletes file" do
      @delete_file_command.execute
      expect(File.exist?("command/test_file.txt")).to be false
    end

    it "undeletes file" do
      @delete_file_command.unexecute
      expect(File.exist?("command/test_file.txt")).to be false
    end
  end

  context "file to delete already exist" do
    before(:example) do
      @path = "command/test_file.txt"
      create_file(@path, "sample content")
      @delete_file_command = DeleteFile.new(@path)
    end

    after(:example) { delete_file(@path) }

    it "deletes file" do
      @delete_file_command.execute
      expect(File.exist?(@path)).to be false
    end

    it "undeletes file" do
      @delete_file_command.unexecute
      expect(File.exist?(@path)).to be true
      expect(File.read(@path)).to eq("sample content")
    end
  end
end
