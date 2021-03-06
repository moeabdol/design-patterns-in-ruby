require_relative "../../adapter/encrypter"
require_relative "../../adapter/decrypter"
require_relative "../../adapter/string_io_adapter"

def write_string_to_file(path, string)
  writer = File.open(path, "w")
  writer.write(string)
  writer.close
end

def read_string_from_file(path)
  if File.exist?(path)
    reader = File.open(path)
    content = reader.read
    reader.close
  end
  content
end

def decrypt_message_in_file(path, key)
  decrypted_message = ""
  key_index = 0
  if File.exist?(path)
    reader = File.open(path)
    until reader.eof?
      encrypted_byte = reader.getbyte
      key_byte = key.getbyte(key_index)
      decrypted_byte = (encrypted_byte ^ key_byte)
      decrypted_message << decrypted_byte.chr("UTF-8")
      key_index = (key_index + 1) % key.size
    end
    reader.close
  end
  decrypted_message
end

describe "Classic Adapter" do
  context "Encrypter/Decrypter" do
    before(:example) do
      @key = "secret key"
      @original_message = "We attack at dawn!\n"
      @encrypted_message = "$ C AYCNJo"
      @original_file = "adapter/original.txt"
      @encrypted_file = "adapter/encrypted.txt"
    end

    describe Encrypter do
      after(:example) do
        File.delete(@original_file)
        File.delete(@encrypted_file)
      end

      it "encrypts message" do
        write_string_to_file(@original_file, @original_message)
        reader = File.open(@original_file)
        writer = File.open(@encrypted_file, "w")
        encrypter = Encrypter.new(@key)
        encrypter.encrypt(reader, writer)
        reader.close
        writer.close
        encrypted_message = read_string_from_file(@encrypted_file)
        decrypted_message = decrypt_message_in_file(@encrypted_file, @key)
        expect(@encrypted_message).to eq(encrypted_message)
        expect(@original_message).to eq(decrypted_message)
      end
    end

    describe Decrypter do
      after(:example) do
        File.delete(@encrypted_file)
      end

      it "decrypts message" do
        write_string_to_file(@encrypted_file, @encrypted_message)
        reader = File.open(@encrypted_file)
        decrypter = Decrypter.new(@key)
        expect{ decrypter.decrypt(reader) }.to \
          output(@original_message).to_stdout
        reader.close
      end
    end
  end

  describe StringIOAdapter do
    before(:example) do
      @message = "Hello World!\n"
      @reader = StringIOAdapter.new(@message)
    end

    it "eof? returns false when not eof" do
      13.times do
        expect(@reader.eof?).to be false
        @reader.getbyte
      end
    end

    it "eof? return true when eof" do
      13.times { @reader.getbyte }
      expect(@reader.eof?).to be true
    end

    it "getbyte of first byte in string" do
      byte = @reader.getbyte
      expect(byte).to eq(72)
      expect(byte.chr("UTF-8")).to eq("H")
    end

    it "raises EOFError when trying to getbyte at eof" do
      13.times { @reader.getbyte }
      expect{ @reader.getbyte }.to raise_error(EOFError)
    end
  end
end
