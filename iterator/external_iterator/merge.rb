require_relative "array_iterator"

def merge(array1, array2)
  merged = []
  iterator1 = ArrayIterator.new(array1)
  iterator2 = ArrayIterator.new(array2)

  while iterator1.has_next? && iterator2.has_next?
    iterator1.item < iterator2.item ? merged << iterator1.next : \
                                      merged << iterator2.next
  end

  while iterator1.has_next?
    merged << iterator1.next
  end

  while iterator2.has_next?
    merged << iterator2.next
  end

  merged
end
