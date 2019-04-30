require 'byebug'

RSpec.describe MarketPlace::PromotionRules::DiscountOnTotal do
  let(:product) { MarketPlace::Store.products.last }
  let(:line_item) { MarketPlace::LineItem.new(product: product, quantity: 4) }
  let!(:market_place) { MarketPlace::Checkout.new(promotion_rules: MarketPlace::Store.promotions) }
  include_context 'reset_adjustments'

  describe '#eligible?' do
    before { market_place.line_items = [line_item] }
    subject { described_class.new(checkout: market_place, line_item: line_item).eligible? }
    it { is_expected.to eq(true) }
  end

  describe '#actionable?' do
    before { market_place.line_items = [line_item] }
    subject { described_class.new(checkout: market_place, line_item: line_item).actionable? }
    it { is_expected.to eq(false) }
  end

  describe '#perform' do
    before { market_place.line_items = [line_item] }
    it 'should create adjustment' do
      expect { described_class.new(checkout: market_place, line_item: line_item).perform }.to change(
        market_place.adjustments, :size).by(1)
      expect(market_place.adjustments.first.amount).to eq(-7.98)
    end
  end
end
