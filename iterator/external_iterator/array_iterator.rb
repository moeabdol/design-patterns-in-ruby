class ArrayIterator
  def initialize(array)
    @array = array.clone
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next
    item = @array[@index]
    @index += 1
    item
  end
end
