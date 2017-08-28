require 'rspec'
require 'array_methods'

describe Array do

  describe "Flat Array" do
    subject(:one_dimensional) { [-1, 0, -1, 2, -2, 1, 2] }

    describe "#my_uniq" do
      it "removes all non-uniq elements" do
        expect(one_dimensional.my_uniq).to eq([-1, 0, 2, -2, 1])
      end
    end

    describe "#two_sum" do
      it "finds matching indicies" do
        expect(one_dimensional.two_sum).to eq([[0, 5], [2, 5], [3, 4], [4, 6]])
      end
      it "returns empty array when no indicies match" do
        expect([1, 2, 3, 4].two_sum).to eq([])
      end
    end
  end

  describe "Multi-dimensional Array" do
    subject(:two_dimensional_square) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
    let(:two_dimensional_rect) { [[1, 2], [3, 4], [5, 6]] }
    let(:empty_arr) { [] }
    let(:one_dimensional_arr) { [1, 2, 3, 4] }

    describe "#my_transpose" do
      it "transposes square matrix" do
        expect(two_dimensional_square.my_transpose).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
      end
      it "transposes recangular matrix" do
        expect(two_dimensional_rect.my_transpose).to eq([[1, 3, 5], [2, 4, 6]])
      end
      it "returns empty array for empty array input" do
        expect(empty_arr.my_transpose).to eq([])
      end
      it "raises error for 1D input" do
        expect{ one_dimensional_arr.my_transpose}
              .to raise_error "Cannot transpose 1D array"
      end
    end
  end

end
