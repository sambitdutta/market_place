RSpec.describe MarketPlace::Utils::Helper do
  let!(:market_place) { MarketPlace::Checkout.new(promotion_rules: MarketPlace::Store.promotions) }
  include_context 'reset_adjustments'

  let!(:klass) { Class.new { include MarketPlace::Utils::Helper } }
  let!(:instance) { klass.new }

  describe '#eligible_rules' do
    before do
      Dir[File.join(File.expand_path('../../..', File.dirname(__FILE__)), 'lib/market_place/promotion_rules/*.rb')].each do |file|
        promotion_klass = Module.const_get("MarketPlace::PromotionRules::#{File.basename(file, '.rb').split("_").map(&:capitalize).join}")
        allow_any_instance_of(promotion_klass).to receive(:eligible?).and_return(true)
      end
    end

    context 'when promotable is a Line::Item object' do
      it 'should return promotion rule class names' do
        expect(instance.eligible_rules(
          market_place, MarketPlace::Store.products[0])).to eq(%w[MarketPlace::PromotionRules::ReducedPriceOnItem])
      end
    end

    context 'when promotable is a Product instance' do
      it 'should return promotion rule class names' do
        expect(instance.eligible_rules(
          market_place, market_place)).to eq(
            %w[MarketPlace::PromotionRules::DiscountOnTotal MarketPlace::PromotionRules::ReducedPriceOnItem])
      end
    end
  end

  describe '#perform_adjustments' do
    before do
      Dir[File.join(File.expand_path('../../..', File.dirname(__FILE__)), 'lib/market_place/promotion_rules/*.rb')].each do |file|
        promotion_klass = Module.const_get("MarketPlace::PromotionRules::#{File.basename(file, '.rb').split("_").map(&:capitalize).join}")
        allow_any_instance_of(promotion_klass).to receive(:eligible?).and_return(true)
        expect_any_instance_of(promotion_klass).to receive(:perform)
      end
    end

    it 'should invioke perform' do
      instance.perform_adjustments(market_place, market_place)
    end
  end
end
