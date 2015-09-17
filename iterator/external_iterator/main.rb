require_relative "array_iterator"

array_iterator = ArrayIterator.new(["Red", "Green", "Blue"])
while array_iterator.has_next?
  puts array_iterator.next
end

array_iterator = ArrayIterator.new("abc")
while array_iterator.has_next?
  puts array_iterator.next
end
