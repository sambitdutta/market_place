RSpec.shared_context 'reset_adjustments' do
  before do
    Dir[File.join(File.expand_path('../..', File.dirname(__FILE__)), 'lib/market_place/promotion_rules/*.rb')].each do |file|
      Module.const_get("MarketPlace::PromotionRules::#{File.basename(file, '.rb').split("_").map(&:capitalize).join}").instance_variable_set(:@adjustment, nil)
    end
  end
end
