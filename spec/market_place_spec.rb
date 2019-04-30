RSpec.describe MarketPlace do
  it "has a version number" do
    expect(MarketPlace::VERSION).not_to be nil
  end

  describe 'integration tests' do
    let!(:market_place) { MarketPlace::Checkout.new(promotion_rules: MarketPlace::Store.promotions) }
    let!(:promotion_handler) { MarketPlace::PromotionHandler.new(market_place) }

    include_context 'reset_adjustments'

    context 'example 1' do
      before do
        market_place.scan(MarketPlace::Store.products[0])
        market_place.scan(MarketPlace::Store.products[1])
        market_place.scan(MarketPlace::Store.products[2])
      end

      it 'total should be 66.78' do
        expect(market_place.total).to eq(66.78)
      end
    end

    context 'example 2' do
      before do
        market_place.scan(MarketPlace::Store.products[0])
        market_place.scan(MarketPlace::Store.products[2])
        market_place.scan(MarketPlace::Store.products[0])
      end

      it 'total should be 36.95' do
        expect(market_place.total).to eq(36.95)
      end
    end

    context 'example 3' do
      before do
        market_place.scan(MarketPlace::Store.products[0])
        market_place.scan(MarketPlace::Store.products[1])
        market_place.scan(MarketPlace::Store.products[0])
        market_place.scan(MarketPlace::Store.products[2])
      end

      it 'total should be 73.76' do
        expect(market_place.total).to eq(73.76)
      end
    end
  end
end
