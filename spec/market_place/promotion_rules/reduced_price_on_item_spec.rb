RSpec.describe MarketPlace::PromotionRules::ReducedPriceOnItem do
  let(:product) { MarketPlace::Store.products.first }
  let(:line_item) { MarketPlace::LineItem.new(product: product, quantity: 2) }
  let!(:market_place) { MarketPlace::Checkout.new(promotion_rules: MarketPlace::Store.promotions) }
  include_context 'reset_adjustments'

  describe '#eligible?' do
    subject { described_class.new(checkout: market_place, line_item: line_item).eligible? }
    it { is_expected.to eq(true) }
  end

  describe '#actionable?' do
    subject { described_class.new(checkout: market_place, line_item: line_item).actionable? }
    it { is_expected.to eq(true) }
  end

  describe '#perform' do
    it 'should create adjustment' do
      expect { described_class.new(checkout: market_place, line_item: line_item).perform }.to change(
        market_place.adjustments, :size).by(1)
      expect(market_place.adjustments.first.amount).to eq(-1.5)
    end
  end
end
