require 'rspec'
require 'stocks'


describe "#pick_stock" do
  subject(:stock_prices) { [6, 2, 1, 3, 4, 6] }
  let(:stock_prices2) { [1, 2, 3] }

  it "outputs most profitable pair of days" do
    expect(stock_prices2.pick_stock).to eq([0, 2])
  end
  it "doesn't sell stock before it buys it" do
    expect(stock_prices.pick_stock).to eq([2, 5])
  end
end
