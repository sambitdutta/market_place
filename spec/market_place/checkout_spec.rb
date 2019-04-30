RSpec.describe MarketPlace::Checkout do
  let!(:market_place) { MarketPlace::Checkout.new(promotion_rules: MarketPlace::Store.promotions) }
  let!(:promotion_handler) { MarketPlace::PromotionHandler.new(market_place) }
  include_context 'reset_adjustments'

  describe '#scan' do
    let!(:item) { MarketPlace::Store.products[0] }

    it 'should add line item' do
      expect { market_place.scan(item) }.to change(market_place.line_items, :size).by(1)
    end

    it 'should perform_adjustments' do
      expect_any_instance_of(MarketPlace::PromotionHandler).to receive(
        :perform_adjustments).with(market_place, kind_of(MarketPlace::LineItem))
      market_place.scan(item)
    end
  end

  describe '#total' do
    before do
      market_place.scan(MarketPlace::Store.products[0])
      market_place.scan(MarketPlace::Store.products[0])
      market_place.scan(MarketPlace::Store.products[1])
    end

    subject { market_place.total }

    it { is_expected.to eq(55.8) }
  end
end
