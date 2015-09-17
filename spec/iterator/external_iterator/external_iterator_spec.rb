require_relative "../../../iterator/external_iterator/array_iterator"
require_relative "../../../iterator/external_iterator/merge.rb"

describe ArrayIterator do
  it "has_next? returns false when empty" do
    array_iterator = ArrayIterator.new([])
    expect(array_iterator).not_to have_next
  end

  it "has_next? returns true when not empty and index is 0" do
    array_iterator = ArrayIterator.new([1, 2, 3])
    expect(array_iterator).to have_next
  end

  it "has_next? returns false when not empty and index is last" do
    array_iterator = ArrayIterator.new([1, 2, 3])
    3.times { array_iterator.next }
    expect(array_iterator).not_to have_next
  end

  it "returns next item" do
    array_iterator = ArrayIterator.new([1, 2, 3])
    3.times { |i| expect(array_iterator.next).to eq(i + 1) }
  end

  it "does not get affected when original array is modified" do
    array = [1, 2, 3]
    array_iterator = ArrayIterator.new(array)
    array[0] = 10
    array[1] = 20
    array[2] = 30
    3.times { |i| expect(array_iterator.next).to eq(i + 1) }
  end

  it "returns item at index" do
    array_iterator = ArrayIterator.new([1, 2, 3])
    3.times do |i|
      expect(array_iterator.item).to eq(i + 1)
      array_iterator.next
    end
  end
end

describe "Merge Sort" do
  it "sorts numbers in ascending order" do
    array1 = [1, 1, 11, 13, 100, 101, 200]
    array2 = [20, 39, 40, 100, 101, 204, 222]
    expect(merge(array1, array2)).to \
      eq([1, 1, 11, 13, 20, 39, 40, 100, 100, 101, 101, 200, 204, 222])
  end
end
