require_relative "for_each_element"

array = ["hello", "world", "of", "ruby"]
for_each_element(array) { |element| puts element }
