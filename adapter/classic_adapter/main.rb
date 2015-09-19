require_relative "encrypter"
require_relative "decrypter"
require_relative "string_io_adapter"

# IO Encryption/Decryption
reader = File.open("adapter/classic_adapter/message.txt")
writer = File.open("adapter/classic_adapter/message.encrypted", "w")
key = "this is the secret key"
encrypter = Encrypter.new(key)
encrypter.encrypt(reader, writer)
reader.close
writer.close

reader = File.open("adapter/classic_adapter/message.encrypted")
decrypter = Decrypter.new(key)
decrypter.decrypt(reader)
reader.close

# String IO Encryption/Decryption
reader = StringIOAdapter.new("We attack at dawn!")
writer = File.open("adapter/classic_adapter/message.encrypted", "w")
encrypter = Encrypter.new(key)
encrypter.encrypt(reader, writer)
writer.close

reader = File.open("adapter/classic_adapter/message.encrypted")
decrypter = Decrypter.new(key)
decrypter.decrypt(reader)
reader.close
