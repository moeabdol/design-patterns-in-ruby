def for_each_element(array)
  array = array.clone
  index = 0
  while index < array.length
    yield array[index]
    index += 1
  end
end
