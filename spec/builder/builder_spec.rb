require_relative "../../builder/drive"
require_relative "../../builder/cpus"
require_relative "../../builder/motherboard"
require_relative "../../builder/computer"
require_relative "../../builder/computer_builder"

describe Drive do
  before(:all) { @drive = Drive.new(:dvd, 4700, true) }

  it "has a type dvd" do
    expect(@drive.type).to eq(:dvd)
  end

  it "has a size 4700" do
    expect(@drive.size).to eq(4700)
  end

  it "is writable" do
    expect(@drive.writable).to be true
  end
end

describe Motherboard do
  before(:all) { @motherboard = Motherboard.new(TurboCPU.new, 4000) }

  it "has turbo cpu" do
    expect(@motherboard.cpu).to be_a(TurboCPU)
  end

  it "has memory size 4000" do
    expect(@motherboard.memory_size).to eq(4000)
  end
end

describe Computer do
  before(:all) do
    drives = [Drive.new(:cd, 760, false), Drive.new(:dvd, 4700, true)]
    cpu = TurboCPU.new
    motherboard = Motherboard.new(cpu, 4000)
    @computer = Computer.new(:crt, motherboard, drives)
  end

  it "has display :crt" do
    expect(@computer.display).to eq(:crt)
  end

  it "has motherboard" do
    expect(@computer.motherboard).to be_a(Motherboard)
  end

  it "has cd and dvd drives" do
    expect(@computer.drives[0].type).to eq(:cd)
    expect(@computer.drives[1].type).to eq(:dvd)
  end
end

describe ComputerBuilder do
  before(:example) { @computer_builder = ComputerBuilder.new }

  it "has a computer instance" do
    expect(@computer_builder.computer).to be_a(Computer)
  end

  it "has a turbo cpu" do
    @computer_builder.turbo
    expect(@computer_builder.computer.motherboard.cpu).not_to be_a(BasicCPU)
    expect(@computer_builder.computer.motherboard.cpu).to be_a(TurboCPU)
  end

  it "does not have turbo cpu" do
    expect(@computer_builder.computer.motherboard.cpu).not_to be_a(TurboCPU)
    expect(@computer_builder.computer.motherboard.cpu).to be_a(BasicCPU)
  end

  it "can add LCD display" do
    @computer_builder.display(:lcd)
    expect(@computer_builder.computer.display).to eq(:lcd)
  end

  it "has memory size 10000" do
    @computer_builder.memory_size(10000)
    expect(@computer_builder.computer.motherboard.memory_size).to eq(10000)
  end

  it "has default memory size of 1000" do
    expect(@computer_builder.computer.motherboard.memory_size).to eq(1000)
  end

  it "can add writable cd drive" do
    @computer_builder.add_cd(true)
    expect(@computer_builder.computer.drives[0].type).to eq(:cd)
    expect(@computer_builder.computer.drives[0].size).to eq(760)
    expect(@computer_builder.computer.drives[0].writable).to be true
  end

  it "can add non-writable dvd drive" do
    @computer_builder.add_dvd
    expect(@computer_builder.computer.drives[0].type).to eq(:dvd)
    expect(@computer_builder.computer.drives[0].size).to eq(4700)
    expect(@computer_builder.computer.drives[0].writable).to be false
  end

  it "can add hard disk drive with 100000 MBytes" do
    @computer_builder.add_hard_disk(100000)
    expect(@computer_builder.computer.drives[0].type).to eq(:hard_disk)
    expect(@computer_builder.computer.drives[0].size).to eq(100000)
    expect(@computer_builder.computer.drives[0].writable).to be true
  end

  it "can only build computers with memory of at least 250 MB" do
    @computer_builder.memory_size(249)
    expect{ @computer_builder.computer }.to raise_error("Not enough memory.")
  end

  it "can only build computers with maximum 4 drives" do
    @computer_builder.add_cd
    @computer_builder.add_dvd
    @computer_builder.add_hard_disk(1000)
    @computer_builder.add_cd
    @computer_builder.add_dvd
    expect{ @computer_builder.computer }.to raise_error("Too many drives.")
  end
end
