require_relative "../../../iterator/internal_iterator/for_each_element"

describe "Internal Iterator" do
  describe "for_each_element" do
    it "iterates over elements" do
      array = ["hello", "world", "of", "ruby"]
      index = 0
      for_each_element(array) do |element|
        expect(array[index]).to eq(element)
        index += 1
      end
    end
  end
end
