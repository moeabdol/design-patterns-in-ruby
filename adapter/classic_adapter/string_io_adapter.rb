class StringIOAdapter
  def initialize(string)
    @string = string
    @index = 0
  end

  def eof?
    @index >= @string.length
  end

  def getbyte
    if @index >= @string.length
      raise EOFError
    else
      chr = @string.getbyte(@index)
      @index += 1
      return chr
    end
  end
end
